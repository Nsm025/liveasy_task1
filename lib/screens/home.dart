import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _value = false;
  int val = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Please select your Profile",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(0.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: ListTile(
              title: Text(
                'Shipper',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              leading: Wrap(children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = 1;
                    });
                  },
                  activeColor: Colors.indigo.shade900,
                ),
                Image.asset("assets/shipper.png"),
              ]),
            ),
          ),
          SizedBox(height: 20),
          Card(
            color: Colors.white,
            borderOnForeground: true,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
            child: ListTile(
              title: Text(
                'Transporter',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              leading: Wrap(children: <Widget>[
                Radio(
                  value: 2,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = 2;
                    });
                  },
                  activeColor: Colors.indigo.shade900,
                ),
                Image.asset("assets/transport.png"),
              ]),
            ),
          ),
          SizedBox(height: 10),
          RaisedButton(
            child: Text("CONTINUE"),
            onPressed: () {},
            color: Colors.indigo.shade900,
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
          ),
        ]),
      ),
    );
  }
}
