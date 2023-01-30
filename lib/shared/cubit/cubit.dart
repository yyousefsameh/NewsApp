import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/modules/Archived_tasks/Archived_Tasks_Screnn.dart';
import 'package:project1/modules/Done_tasks/Done_Tasks_Screen.dart';
import 'package:project1/modules/New_Tasks/New_Tasks_Screen.dart';
import 'package:project1/shared/cubit/states.dart';
import 'package:project1/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntiailState());

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarstate());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title string
        // date string
        // time string
        // status string
        print('database is created');
        database
            .execute(
                'create table tasks (ID INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,time TEXT, date TEXT, status TEXT)')
            .then(
          (value) {
            print('Table is created');
          },
        ).catchError((error) {
          print('Error when crating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);

        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction(
      (txn) {
        return txn
            .rawInsert(
          'INSERT INTO tasks(title, time, date, status) VALUES("$title","$time","$date","new")',
        )
            .then(
          (value) {
            print('$value inserted successfully');
            emit(AppInsertDatabaseState());

            getDataFromDatabase(database);
          },
        ).catchError((error) {
          print('Error When Inserting New record');
        });
      },
    );
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then(
      (List value) {
        value.forEach(
          (element) {
            if (element['status'] == 'new') {
              newTasks.add(element);
            } else if (element['status'] == 'done') {
              doneTasks.add(element);
            } else {
              archivedTasks.add(element);
            }
          },
        );
        emit(AppGetDatabaseState());
      },
    );
  }

  void updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ?  WHERE id = ? ',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabicon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabicon = icon;
    emit(AppChangeBottomSheetstate());
  }

  bool isDark = false;

  void changeAppMode({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModestate());
    } else {
      isDark = !isDark;

      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModestate());
      });
    }
  }
}
