import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/widgets/category_card.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

// list of the categories such as business, sports, ... to be displayed in the horizontal list view
  final List<CategoryModel> categories = const [
    CategoryModel(
      imagePath: 'assets/business.jpeg',
      categoryName: 'Business',
    ),
    CategoryModel(
      imagePath: 'assets/entertainment.jpeg',
      categoryName: 'Entertainment',
    ),
    CategoryModel(
      imagePath: 'assets/general.jpeg',
      categoryName: 'General',
    ),
    CategoryModel(
      imagePath: 'assets/health.jpeg',
      categoryName: 'Health',
    ),
    CategoryModel(
      imagePath: 'assets/science.jpeg',
      categoryName: 'Science',
    ),
    CategoryModel(
      imagePath: 'assets/sports.jpeg',
      categoryName: 'Sports',
    ),
    CategoryModel(
      imagePath: 'assets/technology.jpeg',
      categoryName: 'Technology',
    ),
  ];

// widget to build every single category in the horizontal list view
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categories[index],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 10.0,
          ),
        ),
      ),
    );
  }
}
