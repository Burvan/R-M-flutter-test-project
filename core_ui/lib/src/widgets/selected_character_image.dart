import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_ui/src/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class SelectedCharacterImage extends StatelessWidget {
  final String imagePath;

  const SelectedCharacterImage({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Hero(
      tag: imagePath,
      child: CircleAvatar(
        radius: mediaQueryData.size.width / 5,
        child: ClipOval(
          child: CustomCachedImage(
            imagePath: imagePath,
            imageHeight: null,
          ),
        ),
      ),
    );
  }
}
