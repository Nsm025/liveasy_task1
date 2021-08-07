import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy_task1/services/authservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  late String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.close),
              Text("Please enter your mobile number"),
              SizedBox(height: 5),
              Text("You'll receive a 6 digit code to verify next."),
              SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(0.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black87,
                            width: 1.0,
                          ),
                        ),
                        prefixIcon: Image.network(
                            "https://i0.wp.com/www.looksharpstore.co.nz/wp-content/uploads/2015/08/4124.jpg?fit=875%2C1024&ssl=1",
                            width: 30,
                            height: 30),
                        labelText: "  +91  -",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        alignLabelWithHint: true,
                        hintText: 'Mobile Number'),
                    onChanged: (val) {
                      setState(() {
                        this.phoneNo = val;
                      });
                    },
                  )),
              SizedBox(height: 10),
              codeSent
                  ? Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: 'Enter OTP'),
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                      ))
                  : Container(),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: RaisedButton(
                    child: Center(
                        child: codeSent
                            ? Text('VERIFY AND CONTINUE')
                            : Text('CONTINUE')),
                    onPressed: () {
                      codeSent
                          ? AuthService().signInWithOTP(smsCode, verificationId)
                          : verifyPhone(phoneNo);
                    },
                    color: Colors.indigo.shade900,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(95, 20, 95, 20),
                  ))
            ],
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
