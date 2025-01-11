import 'dart:async';
import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'characters_page_event.dart';
part 'characters_page_state.dart';

class CharactersPageBloc
    extends Bloc<CharactersPageEvent, CharactersPageState> {
  final FetchCharactersUseCase _fetchCharactersUseCase;
  final ClearCachedCharactersUseCase _clearCachedCharactersUseCase;
  final GetCharactersFromCacheUseCase _getCharactersFromCacheUseCase;
  final SaveCharactersToCacheUseCase _saveCharactersToCacheUseCase;
  //late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  CharactersPageBloc({
    required FetchCharactersUseCase fetchCharactersUseCase,
    required ClearCachedCharactersUseCase clearCachedCharactersUseCase,
    required GetCharactersFromCacheUseCase getCharactersFromCacheUseCase,
    required SaveCharactersToCacheUseCase saveCharactersToCacheUseCase,
  })  : _fetchCharactersUseCase = fetchCharactersUseCase,
        _clearCachedCharactersUseCase = clearCachedCharactersUseCase,
        _getCharactersFromCacheUseCase = getCharactersFromCacheUseCase,
        _saveCharactersToCacheUseCase = saveCharactersToCacheUseCase,
        super(
          const CharactersPageState(
            characters: <Character>[],
            currentPage: 1,
            isEndOfList: false,
            isLoading: false,
            statusFilter: null,
            speciesFilter: null,
            isInternetConnection: true,
          ),
        ) {
    on<InitEvent>(_onInit);
    on<FetchCharactersNextPageEvent>(_onFetchCharactersNextPage);
    on<ChangeStatusFilterEvent>(_onChangeStatusFilter);
    on<ChangeSpeciesFilterEvent>(_onChangeSpeciesFilter);

    // _streamSubscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((List<ConnectivityResult> result) {
    // });

    add(const InitEvent());
  }

  // @override
  // Future<void> close() {
  //   _streamSubscription.cancel();
  //   return super.close();
  // }

  Future<void> _onInit(
    InitEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    if (await InternetConnection.isInternetConnection()) {
      await _clearCachedCharactersUseCase.execute(const NoParams());
      add(const FetchCharactersNextPageEvent());
    } else {
      final List<Character> characters =
          await _getCharactersFromCacheUseCase.execute(const NoParams());
      emit(state.copyWith(isLoading: false, characters: characters,),);
    }
  }

  Future<void> _onFetchCharactersNextPage(
    FetchCharactersNextPageEvent event,
    Emitter<CharactersPageState> emit,
  ) async {
    if (state.isEndOfList || state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    final bool isInternetConnection =
        await InternetConnection.isInternetConnection();

    emit(state.copyWith(isInternetConnection: isInternetConnection));

    if (isInternetConnection) {
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

      await _saveCharactersToCacheUseCase.execute(result.characters);

      emit(
        state.copyWith(
          currentPage: result.info.next != null
              ? state.currentPage + 1
              : state.currentPage,
          characters: List.of(state.characters)..addAll(result.characters),
          isLoading: false,
          isEndOfList: result.info.next == null,
        ),
      );
    } else {
      final List<Character> cachedCharacters =
          await _getCharactersFromCacheUseCase.execute(const NoParams());

      List<Character> filteredCachedCharacters = cachedCharacters.where((character) {
        bool statusMatch = true;
        bool speciesMatch = true;
        if (state.statusFilter != null && state.statusFilter != StatusFilter.any){
          statusMatch = character.status.toLowerCase() == state.statusFilter!.name.toLowerCase();
        }
        if (state.speciesFilter != null && state.speciesFilter != SpeciesFilter.any){
          speciesMatch = character.species.toLowerCase() == state.speciesFilter!.name.toLowerCase();
        }
        return statusMatch && speciesMatch;
      }).toList();
      emit(
        state.copyWith(
          characters: filteredCachedCharacters,
          isLoading: false,
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
