import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

// class for making the new tile that will be displayed in the vertical list view
class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.articleModel});
  final ArticleModel articleModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Image.network(
            articleModel.image ??
                'https://th.bing.com/th/id/OIP.j0gy3C3Wyn7e67CA9pwC6gHaHa?w=175&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          articleModel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          articleModel.subTitle ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}
