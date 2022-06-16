import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_database/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;
  String _user = '';
  String _pass = '';

  userData() async {
    prefs = await SharedPreferences.getInstance();
    setState(
      () {
        _user = prefs.getString('userid')!;
        _pass = prefs.getString('password')!;
      },
    );
  }

  @override
  void initState() {
    userData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          centerTitle: true,
          title: Text('HomeScreen'),
          backgroundColor: Colors.black,
          titleTextStyle: GoogleFonts.antic(fontSize: 20),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('UserID :- ${_user}'),
              // FutureBuilder(
              //   future: _user,
              //   builder: (context, snapshot) {
              //     switch (snapshot.connectionState) {
              //       case ConnectionState.waiting:
              //         return Lottie.network(
              //             'https://assets8.lottiefiles.com/packages/lf20_szlepvdh.json');
              //       default:
              //         if (snapshot.hasError) {
              //           return Text('Error: ${snapshot.hasError}');
              //         } else {
              //           return Text('UserID :- ${snapshot.data}');
              //         }
              //     }
              //   },
              // ),
              SizedBox(
                height: 50,
              ),
              Text('Password :- ${_pass}'),
              // FutureBuilder(
              //   future: _pass,
              //   builder: (context, snapshot) {
              //     switch (snapshot.connectionState) {
              //       case ConnectionState.waiting:
              //         return Lottie.network(
              //             'https://assets8.lottiefiles.com/packages/lf20_szlepvdh.json');
              //       default:
              //         if (snapshot.hasError) {
              //           return Text('Error: ${snapshot.hasError}');
              //         } else {
              //           return Text('Password :- ${snapshot.data}');
              //         }
              //     }
              //   },
              // ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  prefs.remove('userid');
                  prefs.remove('password');
                  prefs.remove('Login');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
