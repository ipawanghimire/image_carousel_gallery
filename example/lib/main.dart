import 'package:flutter/material.dart';
import 'package:image_carousel_gallery/image_carousel_gallery.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Carousel Gallery',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Carousel Gallery'),
        ),
        body: const ImageCarouselGallery(
          images: [
            'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
            'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429',
            'https://images.unsplash.com/photo-1500534623283-312aade485b7',
            'https://images.unsplash.com/photo-1470770903676-69b98201ea1c',
            'https://images.unsplash.com/photo-1472214103451-9374bd1c798e',
            'https://images.unsplash.com/photo-1470770841072-f978cf4d019e',
            'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
            'https://images.unsplash.com/photo-1482192596544-9eb780fc7f66',
            'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a',
            'https://images.unsplash.com/photo-1469474968028-56623f02e42e',
            'https://images.unsplash.com/photo-1498050108023-c5249f4df085',
            'https://images.unsplash.com/photo-1441974231531-c6227db76b6e',
            'https://images.unsplash.com/photo-1441716844725-09cedc13a4e7',
            'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f',
          ],
          animationStyle: ImageCarouselAnimationStyle.scale,
          showArrows: false,
        ),
      ),
    );
  }
}
