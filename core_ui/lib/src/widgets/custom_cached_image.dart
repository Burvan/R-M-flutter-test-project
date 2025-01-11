import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  final String imagePath;
  final double? imageHeight;

  const CustomCachedImage({
    required this.imagePath,
    required this.imageHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);

    return CachedNetworkImage(
      imageUrl: imagePath,
      height: imageHeight,
      placeholder: (
        BuildContext context,
        String url,
      ) {
        return const SizedBox(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (BuildContext context, String url, Object error) {
        return Image.asset(
          'assets/images/rm_placeholder.jpeg',
          height: mediaQueryData.size.height * AppScale.scaleZero2,
        );
      },
    );
  }
}
