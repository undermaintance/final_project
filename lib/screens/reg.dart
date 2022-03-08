import 'package:final_project/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  void _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userStoredName', (_userStoredName ?? ''));
    prefs.setString('userStoredPass', (_userStoredPass ?? ''));
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_checkAuthorization()) {
      return Scaffold(
        appBar: myAppBar(Strings.appTitle),
        drawer: navDrawer(context),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CircleAvatar(
                      radius: 100.0,
                      backgroundColor: Colors.yellow,
                      child: Text('Профиль', style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black),)),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    'Главная страница',
                    style: TextStyle(
                        fontSize: 28,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: const [
                      Expanded(child: SizedBox(height: 100)),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: (){
                        _userStoredName ='';
                        _userStoredPass ='';
                        _saveUserData();
                        setState(() {});
                      },
                      child: const Text('Выйти',),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      Strings.authEnterLogin,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: SizedBox()
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: userController,
                            keyboardType: TextInputType.phone,
                            decoration:
                            InputDecoration(
                              labelText: 'Телефон',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Strings.validName;
                              } else if (value.length !=10){
                                return Strings.validNameLength;
                              }
                              return null;
                            },
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: SizedBox()
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: SizedBox()
                        ),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: passController,
                            obscureText: true,
                            decoration:
                            InputDecoration(
                              labelText: 'Пароль',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(36),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Strings.validPass;
                              }
                              return null;
                            },
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: SizedBox()
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 100,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            _userStoredName = userController.text;
                            _userStoredPass = passController.text;
                            if (_checkAuthorization()) {
                              _saveUserData();
                            } else {
                              _userStoredName = '';
                              _userStoredPass = '';
                              _saveUserData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(Strings.authFailed), duration: Duration(seconds: 2)),
                              );
                            }
                          }
                          setState(() {});
                        },
                        child: const Text('Войти',),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text('Демо-доступ:'),
                    const Text('Телефон: ${Strings.userName}'),
                    const Text('Пароль: ${Strings.userPass}'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}