import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final TextStyle secondTextStyle;

  const CustomRichText({
    required this.firstText,
    required this.secondText,
    required this.secondTextStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: AppTextTheme.font20Grey,
        children: <TextSpan>[
          TextSpan(
            text: secondText,
            style: secondTextStyle,
          ),
        ],
      ),
    );
  }
}
