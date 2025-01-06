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
            currentPage: 1,
            isEndOfList: false,
            isLoading: false,
            statusFilter: null,
            speciesFilter: null,
          ),
        ) {
    on<FetchCharactersNextPageEvent>(_onFetchCharactersNextPage);
    on<ChangeStatusFilterEvent>(_onChangeStatusFilter);
    on<ChangeSpeciesFilterEvent>(_onChangeSpeciesFilter);

    add(const FetchCharactersNextPageEvent());
  }

  Future<void> _onFetchCharactersNextPage(
    FetchCharactersNextPageEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    if (state.isEndOfList || state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    final Result result = await _fetchCharactersUseCase.execute(
      Query(page: state.currentPage, queryParams: {
        'status': state.statusFilter?.name == StatusFilter.any.name
            ? null
            : state.statusFilter?.name,
        'species': state.speciesFilter?.name == SpeciesFilter.any.name
            ? null
            : state.speciesFilter?.name,
      }),
    );

    emit(
      state.copyWith(
          currentPage: result.info.next != null
              ? state.currentPage + 1
              : state.currentPage,
          characters: List.of(state.characters)..addAll(result.characters),
          isLoading: false,
          isEndOfList: result.info.next == null),
    );
  }

  void _onChangeStatusFilter(
    ChangeStatusFilterEvent event,
    Emitter<CharactersPageState> emit,
  ) {
    emit(
      state.copyWith(
        characters: [],
        isEndOfList: false,
        currentPage: 1,
        statusFilter: event.status,
      ),
    );
    add(const FetchCharactersNextPageEvent());
  }

  void _onChangeSpeciesFilter(
    ChangeSpeciesFilterEvent event,
    Emitter<CharactersPageState> emit,
  ) {
    emit(
      state.copyWith(
        characters: [],
        isEndOfList: false,
        currentPage: 1,
        speciesFilter: event.species,
      ),
    );

    add(const FetchCharactersNextPageEvent());
  }
}
