import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liveasy_task1/screens/loginpage.dart';
import 'package:liveasy_task1/services/authservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownvalue = 'English';
  var items = ['English'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200),
              Image.asset("assets/picture.png"),
              SizedBox(height: 20),
              Text("Please select your Language",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text("You can change the language any time."),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 100.0, right: 100.0),
                child: DropdownButtonFormField(
                  value: dropdownvalue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(0.0),
                      ),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text("NEXT"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AuthService().handleAuth()),
                  );
                },
                color: Colors.indigo.shade900,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(95, 20, 95, 20),
              ),
              SizedBox(height: 150),
              Positioned.fill(
                child: Image.asset(
                  "assets/front_design.png",
                  width: 700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
