import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/app_button_primary.dart';
import 'package:flash_chat/components/alert_dialog.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  bool isAsyncCall = false;

  Future<void> startLoginProcess(BuildContext context) async {
    {
      setState(() {
        isAsyncCall = true;
      });
      try {
        await loginWithFirebase(context);
        password = null;
        email = null;
      } on FirebaseAuthException catch (e) {
        await DialogBuilder.showAlertDialog(context, e.message);
      } catch (e) {
        print('unexcepted error: $e');
      } finally {
        setState(() {
          isAsyncCall = false;
        });
      }
    }
  }

  Future<void> loginWithFirebase(BuildContext context) async {
    final newUser = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (newUser != null) {
      Navigator.pushNamed(context, ChatScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isAsyncCall,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
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
                    startLoginProcess(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
