class ToggleLikeParams {
  final String postId;
  final String? userId;

  ToggleLikeParams({required this.postId, this.userId});

  factory ToggleLikeParams.empty() {
    return ToggleLikeParams(postId: "", userId: '');
  }

  ToggleLikeParams copyWith({String? postId, String? content, String? userId}) {
    return ToggleLikeParams(
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['user_id'] = userId;
    return data;
  }
}
