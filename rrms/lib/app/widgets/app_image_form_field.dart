import 'package:rrms/_all.dart';

class AppImageFormField extends StatelessWidget {
  final String? label;
  final File? initialValueFile;
  final String? initialValueUrl;
  final double? height;
  final double? width;
  final bool useCropper;
  final void Function(FileInfo? file)? onChanged;
  final void Function()? onClear;
  final MediaPickerButtonCropAspectRatio? cropAspectRatio;
  final Color? contentBackgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? placeholder;

  const AppImageFormField({
    super.key,
    this.label,
    this.initialValueFile,
    this.initialValueUrl,
    this.height,
    this.width,
    this.useCropper = false,
    this.onChanged,
    this.onClear,
    this.cropAspectRatio,
    this.contentBackgroundColor,
    this.contentPadding,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotNullOrEmpty) ...{
          Text(label.value, style: context.textStyle.t16400),
          const Gap(10),
        },
        Container(
          height: height,
          width: width,
          padding: contentPadding,
          decoration: BoxDecoration(
            color: contentBackgroundColor ?? context.appTheme.neutralLight,
            image: placeholder == null
                ? const DecorationImage(
                    image: AssetImage(
                      AppAssets.logo,
                    ),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: () {
            if (initialValueFile != null) {
              return _FileImage(
                file: initialValueFile!,
                useCropper: useCropper,
                onChanged: onChanged,
                onClear: onClear,
                cropAspectRatio: cropAspectRatio,
              );
            }

            if (initialValueUrl.isNotNullOrEmpty) {
              return _ExistingImage(
                url: initialValueUrl.value,
                useCropper: useCropper,
                onChanged: onChanged,
                onClear: onClear,
                cropAspectRatio: cropAspectRatio,
              );
            }

            return _EmptyImage(
              useCropper: useCropper,
              onChanged: onChanged,
              cropAspectRatio: cropAspectRatio,
              placeholder: placeholder,
            );
          }(),
        ),
      ],
    );
  }
}

class _FileImage extends StatelessWidget {
  final File file;
  final bool useCropper;
  final void Function(FileInfo file)? onChanged;
  final void Function()? onClear;
  final MediaPickerButtonCropAspectRatio? cropAspectRatio;

  const _FileImage({
    required this.file,
    required this.useCropper,
    required this.onChanged,
    required this.onClear,
    required this.cropAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appTheme.neutralLight,
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: FileImage(file),
          fit: BoxFit.cover,
        ),
      ),
      child: _ImageActions(
        useCropper: useCropper,
        onChanged: onChanged,
        onClear: onClear,
        cropAspectRatio: cropAspectRatio,
      ),
    );
  }
}

class _ImageActions extends StatelessWidget {
  final bool useCropper;
  final void Function(FileInfo file)? onChanged;
  final void Function()? onClear;
  final MediaPickerButtonCropAspectRatio? cropAspectRatio;

  const _ImageActions({
    required this.useCropper,
    required this.onChanged,
    required this.onClear,
    required this.cropAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: PickImageAction(
            onChanged: onChanged,
            cropAspectRatio: cropAspectRatio,
            useCropper: useCropper,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CancelImageAction(onClear: onClear),
        ),
      ],
    );
  }
}

class PickImageAction extends StatelessWidget {
  const PickImageAction({
    super.key,
    required this.onChanged,
    required this.cropAspectRatio,
    required this.useCropper,
  });

  final void Function(FileInfo file)? onChanged;
  final MediaPickerButtonCropAspectRatio? cropAspectRatio;
  final bool useCropper;

  @override
  Widget build(BuildContext context) {
    return MediaPickerButton(
      onMediaCropped: (items) => onChanged?.call(items.first),
      imageConfig: MediaPickerImageConfig(
        lockCropAspectRatio: cropAspectRatio != null,
        cropAspectRatio: cropAspectRatio,
        useCropper: useCropper,
        fileInfoType: FileInfoType.image,
        context: context,
      ),
      child: const _ImageAction(
        icon: Icons.edit,
      ),
    );
  }
}

class CancelImageAction extends StatelessWidget {
  const CancelImageAction({
    super.key,
    required this.onClear,
  });

  final void Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return _ImageAction(
      icon: Icons.cancel,
      onTap: onClear,
    );
  }
}

class _ImageAction extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;

  const _ImageAction({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 5,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            size: 12,
            color: context.appTheme.secondaryTextStyle.color,
          ),
        ),
      ),
    );
  }
}

class _ExistingImage extends StatelessWidget {
  final String url;
  final bool useCropper;
  final void Function(FileInfo file)? onChanged;
  final void Function()? onClear;
  final MediaPickerButtonCropAspectRatio? cropAspectRatio;

  const _ExistingImage({
    required this.url,
    required this.useCropper,
    required this.onChanged,
    required this.onClear,
    required this.cropAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appTheme.neutralLight,
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
        ),
      ),
      child: _ImageActions(
        useCropper: useCropper,
        onChanged: onChanged,
        onClear: onClear,
        cropAspectRatio: cropAspectRatio,
      ),
    );
  }
}

class _EmptyImage extends StatelessWidget {
  final bool useCropper;
  final void Function(FileInfo file)? onChanged;
  final MediaPickerButtonCropAspectRatio? cropAspectRatio;
  final Widget? placeholder;

  const _EmptyImage({
    required this.useCropper,
    required this.onChanged,
    required this.cropAspectRatio,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return MediaPickerButton(
      onMediaCropped: (items) => onChanged?.call(items.first),
      imageConfig: MediaPickerImageConfig(
        lockCropAspectRatio: cropAspectRatio != null,
        cropAspectRatio: cropAspectRatio,
        useCropper: useCropper,
        fileInfoType: FileInfoType.image,
        context: context,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: placeholder,
      ),
    );
  }
}
