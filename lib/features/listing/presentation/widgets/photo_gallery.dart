import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../shared/widgets/app_network_image.dart';

/// Swipeable listing photo gallery with a page indicator and counter.
class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key, required this.photos});

  final List<String> photos;

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final photos = widget.photos.isEmpty ? [''] : widget.photos;

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: (i) => setState(() => _index = i),
          itemCount: photos.length,
          itemBuilder: (context, i) => AppNetworkImage(url: photos[i]),
        ),
        if (photos.length > 1)
          Positioned(
            bottom: AppSpacing.md,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < photos.length; i++)
                  AnimatedContainer(
                    duration: AppDurations.fast,
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                    width: i == _index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _index ? scheme.onPrimary : scheme.onPrimary.withValues(alpha: 0.5),
                      borderRadius: AppRadii.chipRadius,
                    ),
                  ),
              ],
            ),
          ),
        Positioned(
          top: AppSpacing.md,
          right: AppSpacing.md,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: AppRadii.chipRadius,
            ),
            child: Text('${_index + 1}/${photos.length}',
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
      ],
    );
  }
}
