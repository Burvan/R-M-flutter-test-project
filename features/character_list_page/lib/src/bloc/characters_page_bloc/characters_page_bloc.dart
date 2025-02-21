import 'dart:async';
import 'package:core/core.dart';
import 'package:core/errors/errors.dart';
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
            errorMessage: null,
          ),
        ) {
    on<InitEvent>(_onInit);
    on<FetchCharactersNextPageEvent>(_onFetchCharactersNextPage);
    on<ChangeStatusFilterEvent>(_onChangeStatusFilter);
    on<ChangeSpeciesFilterEvent>(_onChangeSpeciesFilter);

    add(const InitEvent());
  }

  Future<void> _onInit(
    InitEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    add(const FetchCharactersNextPageEvent());
  }

  Future<void> _onFetchCharactersNextPage(
    FetchCharactersNextPageEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    if (state.isEndOfList || state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try{
      final Result result = await _fetchCharactersUseCase.execute(
        Query(
          page: state.currentPage,
          queryParams: {
            'status': state.statusFilter == StatusFilter.any ||
                state.statusFilter == null
                ? null
                : state.statusFilter?.status,
            'species': state.speciesFilter == SpeciesFilter.any ||
                state.speciesFilter == null
                ? null
                : state.speciesFilter?.species,
          },
        ),
      );

      List<Character> charactersToAdd = result.characters;

      if (result.info.next == null) {
        charactersToAdd = charactersToAdd.where((character) {
          bool statusMatch = true;
          bool speciesMatch = true;
          if (state.statusFilter != null &&
              state.statusFilter != StatusFilter.any) {
            statusMatch = character.status.toLowerCase() ==
                state.statusFilter!.status.toLowerCase();
          }
          if (state.speciesFilter != null &&
              state.speciesFilter != SpeciesFilter.any) {
            speciesMatch = character.species.toLowerCase() ==
                state.speciesFilter!.species.toLowerCase();
          }
          return statusMatch && speciesMatch;
        }).toList();
      }

      if (charactersToAdd.isEmpty) {
        throw const ApiException(message: 'No such characters');
      }

      emit(
        state.copyWith(
          currentPage: result.info.next != null
              ? state.currentPage + 1
              : state.currentPage,
          characters: List.of(state.characters)..addAll(charactersToAdd),
          isLoading: false,
          isEndOfList: result.info.next == null,
        ),
      );
    } on ApiException catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'No such characters',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred',
        ),
      );
    }
  }

  Future<void> _onChangeStatusFilter(
    ChangeStatusFilterEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    if (state.isLoading) return;

    emit(
      state.copyWith(
        characters: [],
        isEndOfList: false,
        currentPage: 1,
        statusFilter: event.status,
        isLoading: false,
      ),
    );
    add(const FetchCharactersNextPageEvent());
  }

  Future<void> _onChangeSpeciesFilter(
    ChangeSpeciesFilterEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
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
