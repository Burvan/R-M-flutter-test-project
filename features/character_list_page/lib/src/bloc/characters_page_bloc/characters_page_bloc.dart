import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'characters_page_event.dart';
part 'characters_page_state.dart';

class CharactersPageBloc
    extends Bloc<CharactersPageEvent, CharactersPageState> {
  final FetchCharactersUseCase _fetchCharactersUseCase;

  CharactersPageBloc({
    required FetchCharactersUseCase fetchCharactersUseCase,
  })  : _fetchCharactersUseCase = fetchCharactersUseCase,
        super(
          const CharactersPageState(
            characters: <Character>[],
            isEndOfList: false,
            currentPage: 1,
            isLoading: false,
          ),
        ) {
    on<InitEvent>(_onInit);
    on<FetchCharactersNextPageEvent>(_onFetchCharactersNextPage);

    add(const InitEvent());
  }

  void _onInit(
    InitEvent event,
    Emitter<CharactersPageState> emit,
  ) {
    emit(state.copyWith(isLoading: true));
    add(const FetchCharactersNextPageEvent());
  }

  Future<void> _onFetchCharactersNextPage(
    FetchCharactersNextPageEvent event,
    Emitter<CharactersPageState> emit,
  ) async{
    if(state.isEndOfList) return;
    emit(state.copyWith(isLoading: true));
    final List<Character> characters = await _fetchCharactersUseCase.execute(state.currentPage);
    emit(
      state.copyWith(
        characters: List.of(state.characters)..addAll(characters),
        isLoading: false,
        currentPage: state.currentPage + 1,
        isEndOfList: characters.isEmpty,
      ),
    );
  }
}
