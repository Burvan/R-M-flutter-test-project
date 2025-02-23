import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class DetailedCharacterScreen extends StatelessWidget {
  final Character character;

  const DetailedCharacterScreen({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            character.name,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.padding16,
              vertical: AppPadding.padding10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SelectedCharacterImage(imagePath: character.image),
                    const SizedBox(width: AppSize.size20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomRichText(
                            firstText: AppStrings.status,
                            secondText: character.status,
                            secondTextStyle:
                                character.status == AppStrings.aliveStatus
                                    ? AppTextTheme.font20Green
                                    : (character.status == AppStrings.deadStatus
                                        ? AppTextTheme.font20Red
                                        : AppTextTheme.font20Black),
                          ),
                          const SizedBox(height: AppSize.size5),
                          CustomRichText(
                            firstText: AppStrings.species,
                            secondText: character.species,
                            secondTextStyle: themeData.textTheme.titleLarge!,
                          ),
                          const SizedBox(height: AppSize.size5),
                          CustomRichText(
                            firstText: AppStrings.gender,
                            secondText: character.gender,
                            secondTextStyle: themeData.textTheme.titleLarge!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.size10),
                CustomRichText(
                  firstText: AppStrings.lastKnownLocation,
                  secondText: character.location.name,
                  secondTextStyle: themeData.textTheme.titleLarge!,
                ),
                const SizedBox(height: AppSize.size10),
                CustomRichText(
                  firstText: AppStrings.origin,
                  secondText: character.origin.name,
                  secondTextStyle: themeData.textTheme.titleLarge!,
                ),
                const SizedBox(height: AppSize.size10),
                CustomRichText(
                  firstText: AppStrings.firstSeenIn,
                  secondText: character.episode.first.split('/').last +
                      AppStrings.episode,
                  secondTextStyle: themeData.textTheme.titleLarge!,
                ),
                const SizedBox(height: AppSize.size10),
                CustomRichText(
                  firstText: AppStrings.allEpisodes,
                  secondText: character.episode
                      .map((String episode) => episode.split('/').last)
                      .toList()
                      .toString(),
                  secondTextStyle: themeData.textTheme.titleLarge!,
                ),
                const SizedBox(height: AppSize.size10),
                CustomRichText(
                  firstText: AppStrings.created,
                  secondText: character.created,
                  secondTextStyle: themeData.textTheme.titleLarge!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
