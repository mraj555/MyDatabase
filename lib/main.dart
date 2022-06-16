import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_database/login_screen.dart';
import 'package:my_database/my_sharedpreferences.dart';
import 'package:my_database/my_webview.dart';
import 'package:my_database/splash_screen.dart';
import 'package:my_database/user_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(

      debugShowCheckedModeBanner: false,
      home: UserData(),
    ),
  );
}
