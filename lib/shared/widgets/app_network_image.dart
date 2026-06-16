import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Cached network image with consistent shimmer-free placeholder and a
/// graceful broken-image fallback.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (url.isEmpty) {
      return _fallback(scheme);
    }
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, _) => Container(color: scheme.surfaceContainerHighest),
      errorWidget: (context, _, _) => _fallback(scheme),
    );
  }

  Widget _fallback(ColorScheme scheme) => Container(
        width: width,
        height: height,
        color: scheme.surfaceContainerHighest,
        child: Icon(Icons.image_not_supported_outlined,
            color: scheme.onSurfaceVariant),
      );
}
