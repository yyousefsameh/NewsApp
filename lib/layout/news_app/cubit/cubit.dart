import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/news_app/cubit/states.dart';
import 'package:project1/modules/business/business_screen.dart';
import 'package:project1/modules/science/science_screen.dart';
import 'package:project1/modules/settings_screen/settings_screen.dart';
import 'package:project1/modules/sports/sports_screen.dart';
import 'package:project1/shared/network/remote/dio_helper.dart';

class Newscubit extends Cubit<NewsStates> {
  Newscubit() : super(NewsInitialState());
  static Newscubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
  ];
  List<Widget> screens = [
    BussinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getSports();
    } else if (index == 1) {
      getScience();
    } else if (index == 2) {
      getScience();
    }

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> Sports = [];
  List<dynamic> Science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "eg",
      "category": "business",
      "apiKey": "2cf6a74af7c240ca8e420e0203a9f342",
    }).then((value) {
      business = value.data["articles"];
      print(business[0]["title"]);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (Sports.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "2cf6a74af7c240ca8e420e0203a9f342",
      }).then((value) {
        Sports = value.data["articles"];
        print(Sports[0]["title"]);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (Science.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apiKey": "2cf6a74af7c240ca8e420e0203a9f342",
      }).then((value) {
        Science = value.data["articles"];
        print(Science[0]["title"]);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(url: "v2/everything", query: {
      "q": value,
      "apiKey": "2cf6a74af7c240ca8e420e0203a9f342",
    }).then((value) {
      search = value.data["articles"];
      print(search[0]["title"]);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
