class NewsCategoryModel {
  int newsId;
  String title, slug, image;
  DateTime createdAt;
  NewsCategoryModel(
      this.newsId, this.title, this.slug, this.image, this.createdAt);
  NewsCategoryModel.fromCategory(Map<String, dynamic> json)
      : newsId = int.parse(json['id'].toString()),
        title = json['name'].toString(),
        slug = json['slug'].toString(),
        image = json['image'].toString(),
        createdAt = DateTime.parse(json['created_at'].toString());
}
