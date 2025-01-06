import 'package:core/enums/filters.dart';

extension StatusFilterEx on StatusFilter {
  String get status {
    switch (this) {
      case StatusFilter.any:
        return 'Any status';
      case StatusFilter.alive:
        return 'Alive';
      case StatusFilter.dead:
        return 'Dead';
      case StatusFilter.unknown:
        return 'unknown';
    }
  }
}

extension SpeciesFilterEx on SpeciesFilter {
  String get species {
    switch (this) {
      case SpeciesFilter.any:
        return 'Any species';
      case SpeciesFilter.human:
        return 'Human';
      case SpeciesFilter.alien:
        return 'Alien';
      case SpeciesFilter.humanoid:
        return 'Humanoid';
      case SpeciesFilter.poopybutthole:
        return 'Poopybutthole';
      case SpeciesFilter.mythological:
        return 'Mythological';
      case SpeciesFilter.animal:
        return 'Animal';
      case SpeciesFilter.robot:
        return 'Robot';
      case SpeciesFilter.cronenberg:
        return 'Cronenberg';
      case SpeciesFilter.disease:
        return 'Disease';
      case SpeciesFilter.unknown:
        return 'Unknown';
    }
  }
}
