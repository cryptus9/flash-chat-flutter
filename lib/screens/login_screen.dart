import 'package:flash_chat/components/app_button_primary.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
              child: TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kInputFieldDecoration.copyWith(
                  hintText: 'Enter your Email',
                ),
              ),
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kInputFieldDecoration.copyWith(
                hintText: 'Enter your Password',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Hero(
              tag: 'login',
              child: AppButtonPrimary(
                text: "Log In",
                color: Colors.lightBlueAccent,
                onTapFn: () {
                  // TODO
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
