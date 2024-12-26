import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  final String imagePath;

  const CharacterImage({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Hero(
        tag: imagePath,
        child: Image.network(
          imagePath,
          height: mediaQueryData.size.height * AppScale.scaleZero2,
        ),
    );
  }
}
