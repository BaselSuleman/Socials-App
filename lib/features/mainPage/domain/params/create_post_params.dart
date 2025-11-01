import 'dart:io';

class CreatePostParams {
  final String? content;
  final String? userId;
  final List<String>? mediaUrls;
  final List<File>? mediaFiles;

  CreatePostParams({
    required this.content,
    this.userId,
    this.mediaUrls,
    this.mediaFiles,
  });

  factory CreatePostParams.empty() {
    return CreatePostParams(
      content: "",
      userId: '',
      mediaUrls: [],
      mediaFiles: [],
    );
  }

  CreatePostParams copyWith({
    String? content,
    String? userId,
    List<String>? mediaUrls,
    List<File>? mediaFiles,
  }) {
    return CreatePostParams(
      userId: userId ?? this.userId,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      mediaFiles: mediaFiles ?? this.mediaFiles,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['user_id'] = userId;
    if (mediaUrls != null) data['media_urls'] = mediaUrls;
    return data;
  }
}
