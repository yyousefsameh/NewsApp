import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/news_app/cubit/cubit.dart';
import 'package:project1/layout/news_app/cubit/states.dart';
import 'package:project1/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Newscubit, NewsStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        var list = Newscubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defultTextFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    label_text: 'Search',
                    prefix_icon: Icons.search,
                    onChanged: (value) {
                      Newscubit.get(context).getSearch(value);
                    },
                    validate: (String vlaue) {
                      if (vlaue.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    }),
              ),
              Expanded(
                child: articleBuilder(list, context, isSearch: true),
              ),
            ],
          ),
        );
      }),
    );
  }
}
