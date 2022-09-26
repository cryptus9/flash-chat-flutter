import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/confirmation_dialog.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/MessageBubble.dart';

final _firestore = FirebaseFirestore.instance;
final _collectionId = 'messages';
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final fieldText = TextEditingController();
  String currentMessage;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                var userDidConfirm =
                    await ConfirmationDialog.showConfirmationDialog(
                  context,
                  'Confirmation',
                  'Do you want to log out?',
                );
                if (userDidConfirm) {
                  _auth.signOut();
                  Navigator.pop(context);
                }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: fieldText,
                      onChanged: (value) {
                        currentMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection(_collectionId).add({
                        'text': currentMessage,
                        'sender': loggedInUser.email,
                      });
                      fieldText.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(_collectionId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.lightBlueAccent,
            ),
          );
        }
        var messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          var text = message.get('text');
          var sender = message.get('sender');
          messageBubbles.add(
            MessageBubble(
              sender: sender,
              text: text,
              userIsSender: sender == loggedInUser?.email,
            ),
          );
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          ),
        );
      },
    );
  }
}
