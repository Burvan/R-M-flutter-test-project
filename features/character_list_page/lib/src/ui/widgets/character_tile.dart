import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterTile({
    required this.character,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.padding16,
        vertical: AppPadding.padding10,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppBorderRadius.borderRadius18,
              ),
              color: themeData.primaryColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: AppBorderRadius.borderRadius7,
                  color: themeData.shadowColor,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                CharacterImage(imagePath: character.image),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: AppPadding.padding10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          character.name,
                          style: AppTextTheme.font20Bold,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.circle,
                              size: AppSize.size10,
                              color: character.status == AppStrings.aliveStatus
                                  ? AppColors.green
                                  : (character.status == AppStrings.deadStatus
                                      ? AppColors.red
                                      : AppColors.black),
                            ),
                            const SizedBox(width: AppSize.size2),
                            Expanded(
                              child: Text(
                                character.status +
                                    AppStrings.dash +
                                    character.species,
                                style: AppTextTheme.font17,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          AppStrings.lastKnownLocation,
                          style: themeData.textTheme.titleMedium,
                        ),
                        Text(
                          character.location.name,
                          style: AppTextTheme.font17,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mediaQueryData.size.height * AppScale.scaleZero2,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(AppBorderRadius.borderRadius18),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
