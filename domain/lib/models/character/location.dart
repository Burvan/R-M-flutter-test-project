class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  Location copyWith({
    String? name,
    String? url,
  }) {
    return Location(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  List<Object?> get props => <Object?> [
    name,
    url,
  ];
}
