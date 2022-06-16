import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_database/home_screen.dart';
import 'package:my_database/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences? prefs;
  late String _user;
  late String _sec;

  var _login = TextEditingController();
  var _pass = TextEditingController();
  late bool new_user;
  var _key = GlobalKey<FormState>();

  newUser() async {
    prefs = await SharedPreferences.getInstance();
    new_user = prefs!.getBool('Login') ?? true;

    if (new_user == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    newUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'User Id Must Not Be Empty.';
                      }
                    },
                    controller: _login,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'User ID',
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _pass,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password Not Be Empty';
                      } else if (value.length < 8) {
                        return 'Password Must Be 8 Character';
                      }
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        _user = _login.text;
                        _sec = _pass.text;
                        if (_user.isNotEmpty && _sec.isNotEmpty) {
                          prefs!.setBool('Login', false);
                          prefs!.setString('userid', _user);
                          prefs!.setString('password', _sec);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
