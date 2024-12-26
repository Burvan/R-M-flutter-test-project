import 'package:flutter/material.dart';

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
        foregroundImage: NetworkImage(imagePath),
      ),
    );
  }
}
