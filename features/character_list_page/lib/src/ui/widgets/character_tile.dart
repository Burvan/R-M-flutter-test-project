import 'package:character_list_page/src/bloc/characters_page_bloc/characters_page_bloc.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  const CharacterTile({
    required this.character,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CharactersPageBloc bloc =
        BlocProvider.of<CharactersPageBloc>(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius18),
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.padding16,
          vertical: AppPadding.padding10,
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppBorderRadius.borderRadius18),
            color: AppColors.grey,
            boxShadow: const [
              BoxShadow(
                blurRadius: AppBorderRadius.borderRadius7,
                color: AppColors.black,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Image.network(
                character.image,
                height: mediaQueryData.size.height * AppScale.scaleZero2,
              ),
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
                      const Text(
                        AppStrings.lastKnownLocation,
                        style: AppTextTheme.font17Grey,
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
      ),
    );
  }
}
