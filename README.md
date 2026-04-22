<!-- Image Carousel Gallery -->

A Flutter package for creating an image carousel with a grid.

<h2>Features</h2>

<ul>
  <li>Display an image carousel with automatic sliding.</li>
  <li>Supports landscape and portrait orientations.</li>
  <li>Integrated grid of additional images.</li>
  <li>Infinite scroll.</li>
  <li>Supports network and asset images.</li>
  <li>Network images are cached (with safe fallback on web).</li>
  <li>Customizable indicators, animation styles, and autoplay speed.</li>
  <li>Tap thumbnails to jump to that image.</li>
  <li>Optional custom arrows and spacing.</li>

</ul>
<h2>Support</h2>
  <li>Android</li>
  <li>IOS</li>
  <li>Web</li>
  <li>AndroidTV</li>
  <li>MacOS</li>
  <li>Windows</li>
  <li>AppleTV</li>

<h2>Demo</h2>

![Android Demo](https://asset.cloudinary.com/doeglj63f/616bdcfa9bdaf6ccda65dd724f91ffea)

<h2>Getting Started</h2>

<p>To use this package, add <code>image_carousel_gallery</code> to your <code>pubspec.yaml</code> file:</p>

<pre><code>dependencies:
  image_carousel_gallery: ^2.0.0
</code></pre>

<p>Then run:</p>

<pre><code>$ flutter pub get
</code></pre>

<h2>Usage</h2>

<p>Add <code>ImageCarouselGallery</code> to your widget tree:</p>

<pre><code>import 'package:image_carousel_gallery/image_carousel_gallery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageCarouselGallery(
          images: [
            'https://example.com/image1.jpg',
            'https://example.com/image2.jpg',
            <!-- Add more image URLs as needed -->
          ],
        ),
      ),
    );
  }
}
</code></pre>

<p>Use asset images with the <code>ImageCarouselGallery.asset</code> constructor:</p>

<pre><code>ImageCarouselGallery.asset(
  images: [
    'assets/images/photo_1.png',
    'assets/images/photo_2.png',
  ],
)
</code></pre>

<p>Optional customization:</p>

<pre><code>ImageCarouselGallery(
  images: [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
  ],
  showIndicators: false,
  showBottomRow: false,
  enableNetworkCaching: false,
  bottomRowSpacing: 16,
  showArrows: false,
  animationStyle: ImageCarouselAnimationStyle.none,
  autoPlayInterval: Duration(seconds: 5),
  autoPlayAnimationDuration: Duration(milliseconds: 600),
)
</code></pre>

<p>Custom arrows:</p>

<pre><code>ImageCarouselGallery(
  images: [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
  ],
  leftArrowBuilder: (context, onPressed) {
    return IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: onPressed,
    );
  },
  rightArrowBuilder: (context, onPressed) {
    return IconButton(
      icon: const Icon(Icons.chevron_right),
      onPressed: onPressed,
    );
  },
)
</code></pre>

<h2>Parameters</h2>

<ul>
  <li><code>images</code> (required): list of asset paths or URLs.</li>
  <li><code>imageSource</code>: <code>network</code> or <code>asset</code> (default: network).</li>
  <li><code>showIndicators</code>: show dot indicators (default: true).</li>
  <li><code>showBottomRow</code>: show thumbnail row (default: true).</li>
  <li><code>bottomRowSpacing</code>: gap between carousel and thumbnails (default: 12).</li>
  <li><code>showArrows</code>: show navigation arrows (default: true).</li>
  <li><code>leftArrowBuilder</code>/<code>rightArrowBuilder</code>: custom arrow widgets.</li>
  <li><code>animationStyle</code>: <code>scale</code> or <code>none</code> (default: scale).</li>
  <li><code>autoPlayInterval</code>: delay between slides (default: 4s).</li>
  <li><code>autoPlayAnimationDuration</code>: slide animation duration (default: 800ms).</li>
  <li><code>autoPlayCurve</code>: curve for slide animation (default: easeInOut).</li>
  <li><code>enableNetworkCaching</code>: use cached network images (default: true; web uses <code>Image.network</code>).</li>
</ul>

<p>Remember to register asset paths in your app's <code>pubspec.yaml</code>:</p>

<pre><code>flutter:
  assets:
    - assets/images/
</code></pre>

<h2>Example</h2>

<p>For more detailed examples, check the <a href="example">example</a> folder.</p>

<h2>Additional Information</h2>

<ul>
  <li>For more details, check the <a href="https://pub.dev/documentation/image_carousel_gallery/latest/">API reference</a>.</li>
  <li>Found a bug? <a href="https://github.com/ipawanghimire/image_carousel_gallery/issues">File an issue</a>.</li>
  <li>Want to contribute? <a href="https://github.com/ipawanghimire/image_carousel_gallery/fork">Fork the repository</a>, make your changes, and submit a pull request.</li>
  <li>Questions or suggestions? <a href="mailto:ipawanghimire@gmail.com">Contact us</a>.</li>
</ul>

<h2>License</h2>

<p>This project is licensed under the <a href="LICENSE">MIT License</a>.</p>
