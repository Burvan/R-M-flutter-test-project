part of 'characters_page_bloc.dart';

class CharactersPageState extends Equatable {
  final List<Character> characters;
  final int currentPage;
  final bool isEndOfList;
  final bool isLoading;



  const CharactersPageState({
    required this.characters,
    required this.currentPage,
    required this.isEndOfList,
    required this.isLoading,
  });

  CharactersPageState copyWith({
    List<Character>? characters,
    int? currentPage,
    bool? isEndOfList,
    bool? isLoading,

  }) {
    return CharactersPageState(
      characters: characters ?? this.characters,
      isEndOfList: isEndOfList ?? this.isEndOfList,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        characters,
        isEndOfList,
        currentPage,
        isLoading,
      ];
}
