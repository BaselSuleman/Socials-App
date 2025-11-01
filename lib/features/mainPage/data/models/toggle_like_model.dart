class ToggleLikeModel {
  bool? success;
  String? action;
  int? likeCount;
  String? postId;
  String? userId;

  ToggleLikeModel(
      {this.success, this.action, this.likeCount, this.postId, this.userId});

  ToggleLikeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    action = json['action'];
    likeCount = json['like_count'];
    postId = json['post_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['action'] = action;
    data['like_count'] = likeCount;
    data['post_id'] = postId;
    data['user_id'] = userId;
    return data;
  }
}
