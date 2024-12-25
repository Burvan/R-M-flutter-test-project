import 'package:character_list_page/src/bloc/characters_page_bloc/characters_page_bloc.dart';
import 'package:character_list_page/src/ui/widgets/character_tile.dart';
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
    ); //BlocProvider<CharactersPageBloc>;
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
  double _scrollPosition = 0.0;

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
      _scrollPosition = _scrollController.position.pixels;
      context.read<CharactersPageBloc>().add(
            const FetchCharactersNextPageEvent(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final CharactersPageBloc bloc = context.read<CharactersPageBloc>();

    return BlocBuilder<CharactersPageBloc, CharactersPageState>(
        builder: (context, state) {
      if (state.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollPosition);
            bloc.state.copyWith(isLoading: false);
          }
        });
      }
      return SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: AppColors.indigo,
          //   title: const Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Text(AppStrings.rmCharacters),
          //     ],
          //   ),
          // ),
          body: Stack(
            children: <Widget>[
              ListView.builder(
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
                      );
                    }
                  }),
              Visibility(
                visible: state.isLoading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
