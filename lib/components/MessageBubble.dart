import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.userIsSender});

  final String sender;
  final String text;
  final bool userIsSender;

  BorderRadius createCustomBorderRadius() {
    if (userIsSender) {
      return BorderRadius.only(
          bottomRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
          topLeft: Radius.circular(12.0));
    } else {
      return BorderRadius.only(
          bottomRight: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment:
            userIsSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.grey),
          ),
          Material(
            elevation: 5.0,
            borderRadius: createCustomBorderRadius(),
            color: userIsSender ? Colors.blueGrey : Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
