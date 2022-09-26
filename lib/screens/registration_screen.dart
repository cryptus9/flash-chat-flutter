import 'package:flash_chat/components/app_button_primary.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/alert_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool isInAsyncCall = false;
  String email;
  String password;

  Future<void> startRegistrationProcess(BuildContext context) async {
    setState(() {
      isInAsyncCall = true;
    });
    try {
      await registerWithFirebase(context);
      email = null;
      password = null;
    } on FirebaseAuthException catch (e) {
      await DialogBuilder.showAlertDialog(context, e.message);
    } catch (e) {
      print('unexcepted error: $e');
    } finally {
      setState(() {
        isInAsyncCall = false;
      });
    }
  }

  Future<void> registerWithFirebase(BuildContext context) async {
    final newUser = await _auth.createUserWithEmailAndPassword(
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
        inAsyncCall: isInAsyncCall,
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
              TextField(
                  textAlign: TextAlign.center,
                  style: kInputTextStyle,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kInputFieldDecoration.copyWith(
                    hintText: 'Enter your Email',
                  )),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  style: kInputTextStyle,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kInputFieldDecoration.copyWith(
                    hintText: 'Enter your Password',
                  )),
              SizedBox(
                height: 24.0,
              ),
              Hero(
                tag: 'register',
                child: AppButtonPrimary(
                  text: "Register",
                  color: Colors.blueAccent,
                  onTapFn: () async {
                    await startRegistrationProcess(context);
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
