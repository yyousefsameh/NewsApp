import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Services/news_service.dart';
import 'package:news_app/models/article_model.dart';

import 'package:news_app/widgets/news_list_view.dart';

class NewsSliverListViewBuilder extends StatefulWidget {
  const NewsSliverListViewBuilder({
    super.key,
    required this.category,
  });
  final String category;

  @override
  State<NewsSliverListViewBuilder> createState() =>
      _NewsSliverListViewBuilderState();
}

class _NewsSliverListViewBuilderState extends State<NewsSliverListViewBuilder> {
  var futureData;

  @override
  void initState() {
    super.initState();
    futureData = NewsService(Dio()).getGenralNews(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewsSliverListView(
            articles: snapshot.data!,
          );
        } else if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('oops there was an error, try later'),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
