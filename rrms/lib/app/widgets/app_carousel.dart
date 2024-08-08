import 'package:rrms/_all.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AppCarousel extends StatefulWidget {
  final int index;
  final List<ImageProvider>? items;
  final void Function(int)? onIndexChanged;
  final bool showControls;
  final bool showCloseButton;
  final bool loop;
  final double? height;
  final Color? indicatorColor;
  final Color? indicatorBorderColor;
  final Color? controlColor;

  const AppCarousel({
    super.key,
    this.index = 0,
    this.items,
    this.onIndexChanged,
    this.showControls = true,
    this.showCloseButton = false,
    this.loop = true,
    this.height,
    this.indicatorColor,
    this.indicatorBorderColor,
    this.controlColor,
  });

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  var _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);

    _pageController.addListener(() {
      _currentIndex = _pageController.page.value.toInt();
    });

    setOrientationRotation();
  }

  @override
  void dispose() {
    setOrientationPortrait();

    super.dispose();
  }

  bool get _isFirst => _currentIndex == 0;
  bool get _isLast => _currentIndex == (widget.items.count - 1);
  bool get _hasMoreItems => widget.items.count > 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Dismissible(
            key: Key('Dismissible_image'),
            direction: DismissDirection.vertical,
            onDismissed: (_) => context.pop(),
            child: PhotoViewGallery.builder(
              loadingBuilder: (_, __) => AppShimmer(context.screenWidth, context.screenWidth),
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: widget.items?[index],
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                );
              },
              itemCount: widget.items.count,
              pageController: _pageController,
              onPageChanged: widget.onIndexChanged,
            ),
          ),
          if (widget.showControls && _hasMoreItems && (widget.loop || !_isFirst))
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Button(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.chevron_left, size: 24, color: widget.controlColor ?? Colors.white),
                onTap: () => _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.easeIn),
              ),
            ),
          if (widget.showControls && _hasMoreItems && (widget.loop || !_isLast))
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Button(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.chevron_right, size: 24, color: widget.controlColor ?? Colors.white),
                onTap: () => _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeIn),
              ),
            ),
          if (widget.showCloseButton)
            Positioned(
              top: 30,
              right: 0,
              child: Button(
                onTap: () => context.pop(),
                borderRadius: 50,
                padding: const EdgeInsets.all(20),
                child: Icon(
                  Icons.close,
                  color: context.textStyle.color,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
