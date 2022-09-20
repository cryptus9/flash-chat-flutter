import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/app_button_primary.dart';
import 'package:flash_chat/components/alert_dialog.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
              child: TextField(
                style: kInputTextStyle,
                onChanged: (value) {
                  email = value;
                },
                decoration: kInputFieldDecoration.copyWith(
                  hintText: 'Enter your Email',
                ),
              ),
            ),
            TextField(
              style: kInputTextStyle,
              onChanged: (value) {
                password = value;
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
                  onTapFn: () async {
                    try {
                      print(email);
                      print(password);
                      final newUser = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } on FirebaseAuthException catch (e) {
                      await DialogBuilder.showAlertDialog(context, e.message);
                    } catch (e) {
                      print('unexcepted error');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
