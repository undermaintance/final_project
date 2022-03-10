import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(String label, BuildContext context) =>
    InputDecoration(
      filled: true,
      fillColor: Theme.of(context).secondaryHeaderColor,
      labelText: label,
    );

AppBar myAppBar(String myTitle) => AppBar(
      title: Text(myTitle),
      backgroundColor: Colors.blue,
    );

Drawer navDrawer(context) => Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: SizedBox(
              child: Image(
                image: AssetImage('assets/image.png'),
                height: 200,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Главная'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Список пользователей'),
            onTap: () {
              Navigator.pushNamed(context, '/users');
            },
          ),
        ],
      ),
    );
