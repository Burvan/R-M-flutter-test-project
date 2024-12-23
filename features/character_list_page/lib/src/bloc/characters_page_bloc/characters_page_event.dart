part of 'characters_page_bloc.dart';

abstract class CharactersPageEvent {
  const CharactersPageEvent();
}

class InitEvent extends CharactersPageEvent {
  const InitEvent();
}


class FetchCharactersNextPageEvent extends CharactersPageEvent{
  const FetchCharactersNextPageEvent();
}