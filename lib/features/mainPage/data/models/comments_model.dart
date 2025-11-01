import 'package:micropolis_assessment/features/mainPage/data/models/user_model.dart';

class CommentModel {
  String? commentId;
  String? postId;
  String? userId;
  String? content;
  DateTime? createdAt;
  User? user;

  CommentModel(
      {this.commentId,
        this.postId,
        this.userId,
        this.content,
        this.createdAt,
        this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    postId = json['post_id'];
    userId = json['user_id'];
    content = json['content']??"";
    createdAt = json['created_at'] != null
        ? DateTime.tryParse(json['created_at'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment_id'] = commentId;
    data['post_id'] = postId;
    data['user_id'] = userId;
    data['content'] = content;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

