import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences extends StatefulWidget {
  const MySharedPreferences({Key? key}) : super(key: key);

  @override
  State<MySharedPreferences> createState() => _MySharedPreferencesState();
}

class _MySharedPreferencesState extends State<MySharedPreferences> {
  Future<SharedPreferences> preference = SharedPreferences.getInstance();
  Future<int>? _counter;

  @override
  void initState() {
    _counter = preference.then((value) => value.getInt('Counter') ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleTextStyle: GoogleFonts.archivo(fontSize: 20),
          title: Text('Shared Preferences'),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          elevation: 15,
        ),
        body: Center(
          child: FutureBuilder(
            future: _counter,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Lottie.network(
                      'https://assets8.lottiefiles.com/packages/lf20_szlepvdh.json');
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.hasError}');
                  } else {
                    return Text(
                        'You Pressed Button ${snapshot.data} time${snapshot.data == 0 ? '' : 's'}');
                  }
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrCounter,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _incrCounter() async {
    SharedPreferences prefs = await preference;
    final int counter = (prefs.getInt('Counter') ?? 0) + 1;

    setState(
      () {
        _counter = prefs.setInt('Counter', counter).then((value) => counter);
      },
    );
  }
}
