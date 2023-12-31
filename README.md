<!-- Image Carousel Gallery -->


A Flutter package for creating an image carousel with a grid.

<h2>Features</h2>

<ul>
  <li>Display an image carousel with automatic sliding.</li>
  <li>Supports landscape and portrait orientations.</li>
  <li>Integrated grid of additional images.</li>
  <li>Infinite Scrool.</li>


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
  image_carousel_gallery: ^1.0.0
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
