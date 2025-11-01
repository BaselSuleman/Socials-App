class AddPostCommentParams {
  final String postId;
  final String? content;
  final String? userId;

  AddPostCommentParams({
    required this.postId,
    required this.content,
    this.userId,
  });

  factory AddPostCommentParams.empty() {
    return AddPostCommentParams(postId: "", content: "", userId: '');
  }

  AddPostCommentParams copyWith({
    String? postId,
    String? content,
    String? userId,
  }) {
    return AddPostCommentParams(
      userId: userId ?? this.userId,
      content: content ?? this.content,
      postId: postId ?? this.postId,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['content'] = content;
    data['user_id'] = userId;
    return data;
  }
}
