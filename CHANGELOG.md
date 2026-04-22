## 2.0.0

- Add `ImageCarouselImageSource` to support network and asset images.
- Provide `ImageCarouselGallery` wrapper for the main carousel widget.
- Update docs for asset usage.
- Replace `carousel_slider` with a built-in PageView carousel.
- Add configuration for indicators, arrows, spacing, animation, and caching.

### Migration to 2.x

- Replace `ImageCarouselWithGrid` direct usage with `ImageCarouselGallery` if you prefer the simplified API.
- For asset images, switch to `ImageCarouselGallery.asset(...)` instead of setting `imageSource` manually.
- If running on web or without plugins, set `enableNetworkCaching: false` to avoid platform channel errors.

## 0.0.1

## Initial release
