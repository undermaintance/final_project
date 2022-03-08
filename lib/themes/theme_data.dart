import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(
    String label, BuildContext context) => InputDecoration(
  filled: true,
  fillColor: Theme.of(context).backgroundColor.withAlpha(100),
  labelText: label,
);

AppBar myAppBar(String myTitle) => AppBar(
  backgroundColor: Colors.cyan,
  shadowColor: Colors.deepOrangeAccent,
  title: Text(myTitle),
);

Widget navDrawer(context) => Drawer(
  child: ListView(
    children: [
      DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.cyan,
        ),
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))
                ),
                child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/330px-Google-flutter-logo.svg.png'),
              ),
            ],
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Профиль'),
        onTap: () {
          Navigator.pushNamed(context, '/');
        },
      ),
      ListTile(
        leading: const Icon(Icons.book),
        title: const Text('Список пользователей'),
        onTap: () {
          Navigator.pushNamed(context, '/users');
        },
      ),
    ],
  ),
);