import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarouselWithGrid extends StatefulWidget {
  final List<String> images;

  const ImageCarouselWithGrid({required this.images, Key? key})
      : super(key: key);

  @override
  State<ImageCarouselWithGrid> createState() => _ImageCarouselWithGridState();
}

class _ImageCarouselWithGridState extends State<ImageCarouselWithGrid> {
  late CarouselController _carouselController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
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
              child: CarouselSlider.builder(
                itemCount: widget.images.length,
                carouselController: _carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: isLandscape ? 16 / 9 : 16 / 9,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInOut,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.images[index],
                      width: screenWidth,
                      height:
                          isLandscape ? screenWidth * 0.8 : screenHeight * 0.4,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: isLandscape ? screenHeight * 0.65 : screenHeight * 0.2,
              left: 30,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_circle_left_rounded,
                  color: Colors.white.withOpacity(0.48),
                  size: 56,
                ),
                onPressed: () {
                  _carouselController.previousPage();
                },
              ),
            ),
            Positioned(
              top: isLandscape ? screenHeight * 0.65 : screenHeight * 0.2,
              right: 30,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_circle_right_rounded,
                  color: Colors.white.withOpacity(0.48),
                  size: 56,
                ),
                onPressed: () {
                  _carouselController.nextPage();
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: isLandscape ? screenHeight * 0.3 : screenHeight * 0.1,
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              min(widget.images.length - 1, 4),
              (index) {
                final key = UniqueKey();

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  child: ImageGridItem(
                    key: key,
                    imageUrl: widget.images[
                        (index + _currentIndex + 1) % widget.images.length],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ImageGridItem extends StatelessWidget {
  final String imageUrl;

  const ImageGridItem({required Key key, required this.imageUrl})
      : super(key: key);

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
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
