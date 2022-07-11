class NewsPostModel {
  int id, userId, views;
  String title, image, body;
  NewsPostModel(
      this.id, this.userId, this.views, this.title, this.image, this.body);
  NewsPostModel.fromNews(Map<String, dynamic> json)
      : id = int.parse(json['id'].toString()),
        userId = int.parse(json['user_id'].toString()),
        views = int.parse(json['view_count'].toString()),
        title = json['title'].toString(),
        image = json['image'].toString(),
        body = json['body'].toString();
}
