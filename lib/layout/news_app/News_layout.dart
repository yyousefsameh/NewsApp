import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/news_app/cubit/cubit.dart';
import 'package:project1/layout/news_app/cubit/states.dart';
import 'package:project1/modules/search/search_screen.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/cubit/cubit.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Newscubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Newscubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
