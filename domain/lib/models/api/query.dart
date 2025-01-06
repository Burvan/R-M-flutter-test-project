class Query {
  final int page;
  final Map<String, dynamic>? queryParams;

  Query({
    required this.page,
    this.queryParams,
  });
}