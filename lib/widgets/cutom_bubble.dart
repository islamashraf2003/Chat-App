import 'package:chat_app/Models/messagesModel.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  Message message;
  ChatBubble({required this.message});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 10,
          top: 12,
        ),
        padding: const EdgeInsets.only(left: 20, right: 45, top: 5, bottom: 5),
        decoration: const BoxDecoration(
          color: Color(0xff373E4E), //0xff26252A
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Text(
          message.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  Message message;
  ChatBubbleForFriend({required this.message});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
          top: 12,
        ),
        padding: const EdgeInsets.only(left: 30, right: 20, top: 5, bottom: 5),
        decoration: const BoxDecoration(
          color: Color(0xff7A8194), // Color(0xff2FCC59),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        child: Text(
          message.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
