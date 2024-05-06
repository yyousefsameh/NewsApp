import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/widgets/news_tile.dart';

// class for making every single new tile in the vertical list view
class NewsSliverListView extends StatelessWidget {
  final List<ArticleModel> articles;
  const NewsSliverListView({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: articles.length,
      itemBuilder: (context, index) => NewsTile(
        articleModel: articles[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 22.0,
      ),
    );
  }
}
