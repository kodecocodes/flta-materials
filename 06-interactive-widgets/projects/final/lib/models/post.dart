class Post {
  String profileImageUrl;
  String comment;
  String foodPictureUrl;
  String timestamp;

  Post(
      {this.profileImageUrl,
      this.comment,
      this.foodPictureUrl,
      this.timestamp});

  Post.fromJson(Map<String, dynamic> json) {
    profileImageUrl = json['profileImageUrl'];
    comment = json['comment'];
    foodPictureUrl = json['foodPictureUrl'];
    timestamp = json['timestamp'];
  }
}
