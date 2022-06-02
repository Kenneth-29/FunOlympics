class Video {
  String? id;
  String? title;
  String? description;
  String? url;

  Video({this.id, this.title, this.description, this.url});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_new, prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    return data;
  }
}
