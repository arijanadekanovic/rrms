import 'package:octo_image/octo_image.dart';
import 'package:rrms/_all.dart';
import 'package:photo_view/photo_view.dart';

class CachedImage extends StatelessWidget {
  final String? url;
  final String? blurHash;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final bool zoomEnabled;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final IconData? placeholderIcon;
  final Color? placeholderIconColor;
  final Widget? placeholder;
  final BoxFit placeholderFit;
  final BoxBorder? placeholderBorder;
  final Widget? loader;

  const CachedImage({
    super.key,
    this.url,
    this.blurHash,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.aspectRatio,
    this.zoomEnabled = false,
    this.borderRadius,
    this.border,
    this.placeholderIcon,
    this.placeholderIconColor,
    this.placeholder,
    this.placeholderFit = BoxFit.contain,
    this.placeholderBorder,
    this.loader,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidth = width ?? (height != null && aspectRatio != null ? height.value * aspectRatio.value : null);
    final imageHeight = height ?? (width != null && aspectRatio != null ? width.value / aspectRatio.value : null);

    if (url.isNullOrEmpty) {
      return Container(
        decoration: BoxDecoration(
          border: placeholderBorder,
          borderRadius: borderRadius?.add(BorderRadius.circular(border?.top.width ?? 0)),
          color: context.appTheme.neutralLight,
        ),
        child: SizedBox(
          width: imageWidth,
          height: imageHeight,
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: placeholder ?? Icon(placeholderIcon, color: placeholderIconColor ?? context.secondaryTextStyle.color, size: width ?? height),
          ),
        ),
      );
    }

    Widget? child;

    if (url.value.endsWith('svg')) {
      child = SvgPicture.network(
        url.value,
        fit: fit,
        width: imageWidth,
        height: imageHeight,
        placeholderBuilder: (_) => Container(
          decoration: BoxDecoration(
            border: placeholderBorder,
            borderRadius: borderRadius?.add(BorderRadius.circular(border?.top.width ?? 0)),
            color: context.appTheme.neutralLight,
          ),
          child: SizedBox(
            width: imageWidth,
            height: imageHeight,
            child: placeholder,
          ),
        ),
      );
    } else {
      final imageProvider = CachedNetworkImageProvider(
        url.value,
        errorListener: (_) => debugPrint('CachedImage > FAILED TO LOAD: ${url.value}'),
        cacheKey: 'CACHED_IMAGE_KEY_$url',
      );

      if (zoomEnabled) {
        child = PhotoView(
          imageProvider: imageProvider,
          backgroundDecoration: BoxDecoration(color: Colors.white),
          initialScale: 1.0,
        );
      } else {
        child = OctoImage(
          image: imageProvider,
          progressIndicatorBuilder: (context, progress) {
            if (loader != null) {
              return loader!;
            }

            if (imageHeight != null && imageWidth != null) {
              return AppShimmer(imageHeight, imageWidth, borderRadius?.topLeft.x ?? 0);
            }

            return const Loader.sm();
          },
          errorBuilder: (_, __, ___) => Container(
            decoration: BoxDecoration(
              border: placeholderBorder,
              borderRadius: borderRadius?.add(BorderRadius.circular(border?.top.width ?? 0)),
              color: context.appTheme.neutralLight,
            ),
            child: SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.zero,
                child: placeholder,
              ),
            ),
          ),
          fit: fit,
          width: imageWidth,
          height: imageHeight,
          imageBuilder: (context, child) => ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: child,
          ),
        );
      }
    }

    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius?.add(BorderRadius.circular(border?.top.width ?? 0)),
      ),
      child: child,
    );
  }
}
