class Comment {
  String? id;
  String? username;
  String? comment;

  Comment({this.id, this.username, this.comment});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['comment'] = this.comment;
    return data;
  }
}
