class Post {
  String id;
  String profileImageUrl;
  String comment;
  String foodPictureUrl;
  String timestamp;

  Post({
    this.id,
    this.profileImageUrl,
    this.comment,
    this.foodPictureUrl,
    this.timestamp,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImageUrl = json['profileImageUrl'];
    comment = json['comment'];
    foodPictureUrl = json['foodPictureUrl'];
    timestamp = json['timestamp'];
  }
}
