enum StatusFilter {
  any('Any status'),
  alive('Alive'),
  dead('Dead'),
  unknown('Unknown');

  final String status;

  const StatusFilter(this.status);
}

enum SpeciesFilter {
  any('Any species'),
  human('Human'),
  alien('Alien'),
  humanoid('Humanoid'),
  poopybutthole('Poopybutthole'),
  mythological('Mythological'),
  animal('Animal'),
  robot('Robot'),
  cronenberg('Cronenberg'),
  disease('Disease'),
  unknown('Unknown');

  final String species;

  const SpeciesFilter(this.species);
}