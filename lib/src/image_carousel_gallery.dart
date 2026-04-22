import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageCarouselImageSource {
  network,
  asset,
}

enum ImageCarouselAnimationStyle {
  none,
  scale,
}

class ImageCarouselWithGrid extends StatefulWidget {
  final List<String> images;
  final ImageCarouselImageSource imageSource;
  final bool enableNetworkCaching;
  final bool showIndicators;
  final bool showBottomRow;
  final double bottomRowSpacing;
  final bool showArrows;
  final Widget Function(BuildContext context, VoidCallback? onPressed)?
      leftArrowBuilder;
  final Widget Function(BuildContext context, VoidCallback? onPressed)?
      rightArrowBuilder;
  final ImageCarouselAnimationStyle animationStyle;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;

  const ImageCarouselWithGrid({
    required this.images,
    this.imageSource = ImageCarouselImageSource.network,
    this.enableNetworkCaching = true,
    this.showIndicators = true,
    this.showBottomRow = true,
    this.bottomRowSpacing = 12,
    this.showArrows = true,
    this.leftArrowBuilder,
    this.rightArrowBuilder,
    this.animationStyle = ImageCarouselAnimationStyle.scale,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.easeInOut,
    Key? key,
  }) : super(key: key);

  const ImageCarouselWithGrid.asset({
    required this.images,
    this.enableNetworkCaching = true,
    this.showIndicators = true,
    this.showBottomRow = true,
    this.bottomRowSpacing = 12,
    this.showArrows = true,
    this.leftArrowBuilder,
    this.rightArrowBuilder,
    this.animationStyle = ImageCarouselAnimationStyle.scale,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.easeInOut,
    Key? key,
  })  : imageSource = ImageCarouselImageSource.asset,
        super(key: key);

  @override
  State<ImageCarouselWithGrid> createState() => _ImageCarouselWithGridState();
}

class _ImageCarouselWithGridState extends State<ImageCarouselWithGrid> {
  static const double _viewportFraction = 0.9;

  late PageController _pageController;
  Timer? _autoPlayTimer;
  int _currentPage = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = _initialPage();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: _viewportFraction,
    );
    _startAutoPlay();
  }

  @override
  void didUpdateWidget(ImageCarouselWithGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.images.length != widget.images.length) {
      _currentPage = _initialPage();
      _currentIndex = 0;
      _pageController.dispose();
      _pageController = PageController(
        initialPage: _currentPage,
        viewportFraction: _viewportFraction,
      );
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int _initialPage() {
    if (widget.images.isEmpty) {
      return 0;
    }

    return widget.images.length * 1000;
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    if (widget.images.length < 2) {
      return;
    }

    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted) {
        return;
      }

      _animateToPage(_currentPage + 1);
    });
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: widget.autoPlayAnimationDuration,
      curve: widget.autoPlayCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Check the device orientation
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: screenWidth,
              height: isLandscape ? screenWidth * 0.8 : screenHeight * 0.4,
              child: PageView.builder(
                controller: _pageController,
                itemCount:
                    widget.images.length > 1 ? null : widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    _currentIndex = index % widget.images.length;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      final double page = _pageController.hasClients
                          ? (_pageController.page ?? _currentPage.toDouble())
                          : _currentPage.toDouble();
                      final double distance = (page - index).abs();
                      final double scale = widget.animationStyle ==
                              ImageCarouselAnimationStyle.scale
                          ? (1 - (distance * 0.1)).clamp(0.9, 1.0)
                          : 1.0;

                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildImage(
                        widget.images[index % widget.images.length],
                        width: screenWidth,
                        height: isLandscape
                            ? screenWidth * 0.8
                            : screenHeight * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: isLandscape ? screenHeight * 0.65 : screenHeight * 0.2,
              left: 30,
              child: widget.showArrows
                  ? _buildArrow(
                      onPressed: widget.images.length < 2
                          ? null
                          : () {
                              _animateToPage(_currentPage - 1);
                            },
                      builder: widget.leftArrowBuilder,
                      icon: Icons.arrow_circle_left_rounded,
                    )
                  : const SizedBox.shrink(),
            ),
            Positioned(
              top: isLandscape ? screenHeight * 0.65 : screenHeight * 0.2,
              right: 30,
              child: widget.showArrows
                  ? _buildArrow(
                      onPressed: widget.images.length < 2
                          ? null
                          : () {
                              _animateToPage(_currentPage + 1);
                            },
                      builder: widget.rightArrowBuilder,
                      icon: Icons.arrow_circle_right_rounded,
                    )
                  : const SizedBox.shrink(),
            ),
            if (widget.showIndicators)
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: _IndicatorRow(
                  itemCount: widget.images.length,
                  currentIndex: _currentIndex,
                ),
              ),
          ],
        ),
        if (widget.showBottomRow) SizedBox(height: widget.bottomRowSpacing),
        if (widget.showBottomRow)
          SizedBox(
            height: isLandscape ? screenHeight * 0.3 : screenHeight * 0.1,
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                max(0, min(widget.images.length - 1, 4)),
                (index) {
                  final key = UniqueKey();

                  return GestureDetector(
                    onTap: () {
                      _animateToPage(_currentPage + index + 1);
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 800),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      child: ImageGridItem(
                        key: key,
                        imageUrl: widget.images[
                            (index + _currentIndex + 1) % widget.images.length],
                        imageSource: widget.imageSource,
                        enableNetworkCaching: widget.enableNetworkCaching,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildArrow({
    required IconData icon,
    required VoidCallback? onPressed,
    Widget Function(BuildContext context, VoidCallback? onPressed)? builder,
  }) {
    if (builder != null) {
      return builder(context, onPressed);
    }

    return IconButton(
      icon: Icon(
        icon,
        color: Colors.white.withValues(alpha: 0.48),
        size: 56,
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildImage(
    String imageUrl, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    switch (widget.imageSource) {
      case ImageCarouselImageSource.asset:
        return Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
        );
      case ImageCarouselImageSource.network:
        if (!widget.enableNetworkCaching || kIsWeb) {
          return Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
          );
        }

        return CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => const SizedBox.shrink(),
          errorWidget: (context, url, error) => const Icon(
            Icons.broken_image_outlined,
          ),
        );
    }
  }
}

class ImageGridItem extends StatelessWidget {
  final String imageUrl;
  final ImageCarouselImageSource imageSource;
  final bool enableNetworkCaching;

  const ImageGridItem({
    required Key key,
    required this.imageUrl,
    required this.imageSource,
    required this.enableNetworkCaching,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _buildImage(imageUrl),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    switch (imageSource) {
      case ImageCarouselImageSource.asset:
        return Image.asset(
          imageUrl,
          fit: BoxFit.cover,
        );
      case ImageCarouselImageSource.network:
        if (!enableNetworkCaching || kIsWeb) {
          return Image.network(
            imageUrl,
            fit: BoxFit.cover,
          );
        }

        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox.shrink(),
          errorWidget: (context, url, error) => const Icon(
            Icons.broken_image_outlined,
          ),
        );
    }
  }
}

class ImageCarouselGallery extends StatelessWidget {
  final List<String> images;
  final ImageCarouselImageSource imageSource;
  final bool enableNetworkCaching;
  final bool showIndicators;
  final bool showBottomRow;
  final double bottomRowSpacing;
  final bool showArrows;
  final Widget Function(BuildContext context, VoidCallback? onPressed)?
      leftArrowBuilder;
  final Widget Function(BuildContext context, VoidCallback? onPressed)?
      rightArrowBuilder;
  final ImageCarouselAnimationStyle animationStyle;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;

  const ImageCarouselGallery({
    required this.images,
    this.imageSource = ImageCarouselImageSource.network,
    this.enableNetworkCaching = true,
    this.showIndicators = true,
    this.showBottomRow = true,
    this.bottomRowSpacing = 12,
    this.showArrows = true,
    this.leftArrowBuilder,
    this.rightArrowBuilder,
    this.animationStyle = ImageCarouselAnimationStyle.scale,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.easeInOut,
    Key? key,
  }) : super(key: key);

  const ImageCarouselGallery.asset({
    required this.images,
    this.enableNetworkCaching = true,
    this.showIndicators = true,
    this.showBottomRow = true,
    this.bottomRowSpacing = 12,
    this.showArrows = true,
    this.leftArrowBuilder,
    this.rightArrowBuilder,
    this.animationStyle = ImageCarouselAnimationStyle.scale,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.easeInOut,
    Key? key,
  })  : imageSource = ImageCarouselImageSource.asset,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageCarouselWithGrid(
      images: images,
      imageSource: imageSource,
      enableNetworkCaching: enableNetworkCaching,
      showIndicators: showIndicators,
      showBottomRow: showBottomRow,
      bottomRowSpacing: bottomRowSpacing,
      showArrows: showArrows,
      leftArrowBuilder: leftArrowBuilder,
      rightArrowBuilder: rightArrowBuilder,
      animationStyle: animationStyle,
      autoPlayInterval: autoPlayInterval,
      autoPlayAnimationDuration: autoPlayAnimationDuration,
      autoPlayCurve: autoPlayCurve,
    );
  }
}

class _IndicatorRow extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const _IndicatorRow({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final bool isActive = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: isActive ? 16 : 6,
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white.withValues(alpha: 0.9)
                : Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
