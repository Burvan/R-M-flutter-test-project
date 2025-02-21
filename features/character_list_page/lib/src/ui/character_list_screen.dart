import 'package:character_list_page/character_list_page.dart';
import 'package:character_list_page/src/bloc/characters_page_bloc/characters_page_bloc.dart';
import 'package:character_list_page/src/ui/widgets/animated_filter_dropdown.dart';
import 'package:character_list_page/src/ui/widgets/character_tile.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersPageBloc>(
      create: (_) => CharactersPageBloc(
        fetchCharactersUseCase: appLocator.get<FetchCharactersUseCase>(),
      ),
      child: const _CharactersPage(),
    );
  }
}

class _CharactersPage extends StatefulWidget {
  const _CharactersPage({
    super.key,
  });

  @override
  State<_CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<_CharactersPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 100);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CharactersPageBloc>().add(
            const FetchCharactersNextPageEvent(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersPageBloc, CharactersPageState>(
        builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.padding10,
                      horizontal: AppPadding.padding10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          AppStrings.filters,
                          style: AppTextTheme.font20Bold,
                        ),
                        AnimatedFilterDropdown(
                          items: StatusFilter.values
                              .map((filter) => filter.status)
                              .toList(),
                          hintText: AppStrings.anyStatus,
                          initialValue: state.statusFilter?.status,
                          onSelected: (String? value) {
                            context.read<CharactersPageBloc>().add(
                                  ChangeStatusFilterEvent(
                                    value == null
                                        ? null
                                        : StatusFilter.values.firstWhere(
                                            (filter) => filter.status == value,
                                          ),
                                  ),
                                );
                          },
                        ),
                        const SizedBox(width: AppSize.size5),
                        AnimatedFilterDropdown(
                          items: SpeciesFilter.values
                              .map((filter) => filter.species)
                              .toList(),
                          hintText: AppStrings.anySpecies,
                          initialValue: state.speciesFilter?.species,
                          onSelected: (String? value) {
                            context.read<CharactersPageBloc>().add(
                                  ChangeSpeciesFilterEvent(
                                    value == null
                                        ? null
                                        : SpeciesFilter.values.firstWhere(
                                            (filter) => filter.species == value,
                                          ),
                                  ),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: (state.errorMessage != null)
                        ? Center(
                            child: AnimatedText(
                              text: state.errorMessage!,
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: state.isEndOfList
                                ? state.characters.length
                                : state.characters.length + 1,
                            itemBuilder: (_, int index) {
                              if (index >= state.characters.length) {
                                return const SizedBox();
                              } else {
                                return CharacterTile(
                                  character: state.characters.elementAt(index),
                                  onTap: () {
                                    context.navigateTo(
                                      DetailedCharacterRoute(
                                        character: state.characters[index],
                                      ),
                                    );
                                  },
                                );
                              }
                            }),
                  ),
                ],
              ),
              if (state.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      );
    });
  }
}
