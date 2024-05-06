class ArticleModel {
  final String? image;
  final String title;
  final String? subTitle;

  ArticleModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });

  factory ArticleModel.fromJsonDataOfApi(jsonData) {
    return ArticleModel(
      image: jsonData['urlToImage'],
      title: jsonData['title'],
      subTitle: jsonData['description'],
    );
  }
}
