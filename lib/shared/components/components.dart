import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:project1/modules/web_view/web_view_screen.dart';
import 'package:project1/shared/cubit/cubit.dart';

Widget defultButton({
  double width = double.infinity,
  Color background: Colors.blue,
  bool isUppercase = true,
  double radius = 3.0,
  Function? function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
//******************************************** *//
//******************************************** *//
//******************************************** *//
//Text Form Field
Widget defultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label_text,
  required IconData prefix_icon,
  IconData? suffix_icon,
  bool isPassword = false,
  Function? SuffixPressed,
  void onTap,
  Function? onSubmit,
  Function? onChanged,
  required Function validate,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label_text,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix_icon),
        suffixIcon: suffix_icon != null
            ? IconButton(
                icon: Icon(suffix_icon),
                onPressed: () {
                  SuffixPressed!();
                },
              )
            : null,
      ),
      onTap: () {
        onTap;
      },
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChanged!(s);
      },
      validator: (s) {
        return validate(s);
      },
    );
/*   *************************************************** 
    ****************************************************
    ****************************************************
     */

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['ID'].toString()),
      background: Container(
          child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          color: Colors.blue),
      resizeDuration: Duration(seconds: 1),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['ID']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['ID'],
                );
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['ID'],
                );
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
/*****************************************
     * ***************************************
     * ***************************************
     */
Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, index) => mydivider(),
          itemCount: tasks.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet,Please Add Some Tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
/*****************************************
     * ***************************************
     * ***************************************
     */

Widget mydivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
/*****************************************
     * ***************************************
     * ***************************************
     */
Widget buildArticleItem(article, context) => InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(
            article['url'],
          ),
        );
      },
    );
/*****************************************
     * ***************************************
     * ***************************************
     */
Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => mydivider(),
          itemCount: 9),
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );

//navigation to pages

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
