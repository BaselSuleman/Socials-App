import 'package:micropolis_assessment/features/mainPage/data/models/user_model.dart';

import '../../../../core/data/enums/post_status_enum.dart';


class PostModel {
  String? postId;
  String? userId;
  String? content;
  List<String>? mediaUrls;
  PostStatus? status;
  DateTime? createdAt;
  int? likeCount;
  int? commentCount;
  User? user;
  bool? hasNewStory;
  bool? isLiked;

  PostModel({
    this.postId,
    this.userId,
    this.content,
    this.mediaUrls,
    this.status,
    this.createdAt,
    this.likeCount,
    this.commentCount,
    this.user,
    this.hasNewStory = true,
    this.isLiked = false,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    userId = json['user_id'];
    content = json['content'];
    mediaUrls = (json['media_urls'] != null)
        ? List<String>.from(json['media_urls'])
        : [];
    status = _statusFromString(json['status']);
    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;
    likeCount = json['like_count'];
    commentCount = json['comment_count'] ?? 0;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    isLiked = false;
    hasNewStory = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['user_id'] = userId;
    data['content'] = content;
    data['media_urls'] = mediaUrls;
    data['status'] = _statusToString(status);
    data['created_at'] = createdAt?.toIso8601String();
    data['like_count'] = likeCount;
    data['comment_count'] = commentCount;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  PostStatus? _statusFromString(String? status) {
    if (status == null) return null;
    switch (status.toUpperCase()) {
      case 'PENDING_APPROVAL':
        return PostStatus.PENDING_APPROVAL;
      case 'APPROVED':
        return PostStatus.APPROVED;
      case 'NOT_APPROVED':
        return PostStatus.NOT_APPROVED;
      default:
        return null;
    }
  }

  String? _statusToString(PostStatus? status) {
    if (status == null) return null;
    switch (status) {
      case PostStatus.PENDING_APPROVAL:
        return 'pending';
      case PostStatus.APPROVED:
        return 'approved';
      case PostStatus.NOT_APPROVED:
        return 'not_approved';
    }
  }

  PostModel copyWith({
    String? postId,
    String? userId,
    String? content,
    List<String>? mediaUrls,
    PostStatus? status,
    DateTime? createdAt,
    int? likeCount,
    int? commentCount,
    User? user,
    bool? hasNewStory,
    bool? isLiked,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      user: user ?? this.user,
      hasNewStory: hasNewStory ?? this.hasNewStory,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
