import 'dart:async';
import 'package:final_project/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/strings.dart';
import 'package:final_project/models/user_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int userID = ModalRoute.of(context)!.settings.arguments as int;

    return TaskScreen(userID: userID);
  }
}

class TaskScreen extends StatefulWidget {
  final int userID;
  const TaskScreen({Key? key, required this.userID}) : super(key: key);


  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  late Future<User> _futureUser;
  late Future<TaskList> _futureTaskList;

  String? _userStoredName;
  String? _userStoredPass;

  bool _checkAuthorization() {
    if ((_userStoredName == Strings.userName)&&(_userStoredPass == Strings.userPass)) {
      return true;
    }
    return false;
  }

  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userStoredName = (prefs.getString('userStoredName') ?? '');
      _userStoredPass = (prefs.getString('userStoredPass') ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _futureUser = fetchSingleUser(widget.userID);
    _futureTaskList = fetchTaskList(widget.userID);
  }
  @override
  Widget build(BuildContext context) {
    if (_checkAuthorization()) {
      return Scaffold(
        appBar: myAppBar(Strings.taskScreenTitle),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                FutureBuilder<User>(
                    future: _futureUser,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.userWidget(context);
                      } else if (snapshot.hasError) {
                        return Text("Ошибка: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }
                ),
                const SizedBox(height: 5),
                Text("Список задач:", style: Theme.of(context).textTheme.headline6),
                FutureBuilder<TaskList>(
                    future: _futureTaskList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.items.length,
                            itemBuilder:(BuildContext context, int index) {
                              return Container(
                                height: 40,
                                color: (index % 2 == 1 ?
                                Theme.of(context).primaryColor.withOpacity(0.25):
                                Theme.of(context).primaryColor.withOpacity(0.05)),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Text(snapshot.data!.items[index].title, style: Theme.of(context).textTheme.bodyText1,)
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                          value: snapshot.data!.items[index].completed,
                                          onChanged: (bool? value) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Ошибка: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    }
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Text(
                  Strings.authFail,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}