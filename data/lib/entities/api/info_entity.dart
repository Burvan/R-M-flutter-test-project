class InfoEntity {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  InfoEntity({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory InfoEntity.fromJson(Map<String, dynamic> json) {
    return InfoEntity(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }
}
