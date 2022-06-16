import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  var _name = TextEditingController();
  var _age = TextEditingController();
  var _location = TextEditingController();

  late SharedPreferences prefs;
  List<String> userData = [];
  String name = '';
  String age = '';
  String location = '';

  dataStore() async {
    prefs = await SharedPreferences.getInstance();

    userData = prefs.getStringList('data') ?? [];
  }

  @override
  void initState() {
    dataStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: GoogleFonts.archivoBlack(fontSize: 20),
          backgroundColor: Colors.black,
          title: Text('UserData'),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          elevation: 15,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          labelText: 'Name',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          alignLabelWithHint: true,
                          hintText: 'Enter Your Name',
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _age,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.cake),
                          labelText: 'Age',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          alignLabelWithHint: true,
                          hintText: 'Enter Your Age',
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _location,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on_sharp),
                          labelText: 'Location',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          alignLabelWithHint: true,
                          hintText: 'Enter Your Location',
                        ),
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(
                                () {
                                  name = _name.text;
                                  age = _age.text;
                                  location = _location.text;
                                  prefs.setStringList(
                                      'data', [name, age, location]);
                                },
                              );
                            },
                            child: Text('Save'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(
                                () {
                                  userData = prefs.getStringList('data')!;
                                },
                              );
                            },
                            child: Text('Load'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              prefs.remove('data');
                              setState(
                                () {
                                  userData.clear();
                                },
                              );
                            },
                            child: Text('Clear'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: Column(
                    children: [
                      Text('Name :- \n${userData.isEmpty ? '' : userData[0]}',
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Age :- \n${userData.isEmpty ? '' : userData[1]}',
                          textAlign: TextAlign.center),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Location :- \n${userData.isEmpty ? '' : userData[2]}',
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
