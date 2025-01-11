part of 'characters_page_bloc.dart';

class CharactersPageState extends Equatable {
  final List<Character> characters;
  final int currentPage;
  final bool isEndOfList;
  final bool isLoading;
  final StatusFilter? statusFilter;
  final SpeciesFilter? speciesFilter;
  final bool isInternetConnection;

  const CharactersPageState({
    required this.characters,
    required this.currentPage,
    required this.isEndOfList,
    required this.isLoading,
    required this.isInternetConnection,
    this.statusFilter,
    this.speciesFilter,
  });

  CharactersPageState copyWith({
    List<Character>? characters,
    int? currentPage,
    bool? isEndOfList,
    bool? isLoading,
    StatusFilter? statusFilter,
    SpeciesFilter? speciesFilter,
    bool? isInternetConnection,
  }) {
    return CharactersPageState(
      characters: characters ?? this.characters,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      statusFilter: statusFilter ?? this.statusFilter,
      speciesFilter: speciesFilter ?? this.speciesFilter,
      isInternetConnection: isInternetConnection ?? this.isInternetConnection,
    );
  }

  @override
  List<Object?> get props => [
        characters,
        isEndOfList,
        currentPage,
        isLoading,
        statusFilter,
        speciesFilter,
        isInternetConnection,
      ];
}
