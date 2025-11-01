class GetPostListParams {
  GetPostListParams({required this.page, required this.limit, this.userId});

  final int page;
  final int limit;
  final String? userId;

  factory GetPostListParams.empty() {
    return GetPostListParams(page: 1, limit: 10, userId: '');
  }

  GetPostListParams copyWith({int? page, int? limit, String? userId}) {
    return GetPostListParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['page'] = page;
    data['limit'] = limit;
    if (userId != null) data['user_id'] = userId;
    return data;
  }
}
