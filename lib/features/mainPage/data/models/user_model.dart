class User {
  String? userId;
  String? username;
  String? unitDetails;
  String? profileImage;

  User({this.userId, this.username, this.unitDetails,this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    unitDetails = json['unit_details'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['unit_details'] = unitDetails;
    return data;
  }
}
