part of 'characters_page_bloc.dart';

abstract class CharactersPageEvent {
  const CharactersPageEvent();
}

class FetchCharactersNextPageEvent extends CharactersPageEvent {
  const FetchCharactersNextPageEvent();
}

class ChangeStatusFilterEvent extends CharactersPageEvent {
  final StatusFilter? status;

  const ChangeStatusFilterEvent(this.status);
}

class ChangeSpeciesFilterEvent extends CharactersPageEvent {
  final SpeciesFilter? species;

  const ChangeSpeciesFilterEvent(this.species);
}

