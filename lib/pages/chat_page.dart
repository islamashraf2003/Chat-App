import 'package:chat_app/Models/messagesModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/cutom_bubble.dart';

class ChatPage extends StatelessWidget {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  static String id = 'ChatPage';
  Widget build(BuildContext context) {
    var email =
        ModalRoute.of(context)!.settings.arguments; //get email form login page
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            backgroundColor:
                Color(0xff1B202D), //const Color.fromARGB(255, 0, 0, 0),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xff1B202D),
              automaticallyImplyLeading: false,
              //centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logoChat.png',
                    width: 48,
                    height: 30,
                  ),
                  const Text(
                    'Chat App',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (contect, index) {
                        return messageList[index].id == email
                            ? ChatBubble(
                                message: messageList[index],
                              )
                            : ChatBubbleForFriend(
                                message: messageList[index],
                                email: messageList[index].id,
                              );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      final messageText = controller.text;
                      if (messageText.isNotEmpty) {
                        messages.add({
                          'message': data,
                          'createdAt': DateTime.now(),
                          'id': email,
                        });
                      }
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 600),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Message',
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      fillColor: Colors.grey[900],
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Color(0xff9398A7),
                        ),
                        onPressed: () {
                          // Implement your send message functionality here
                          final messageText = controller.text;
                          if (messageText.isNotEmpty) {
                            messages.add({
                              'message': messageText,
                              'createdAt': DateTime.now(),
                              'id': email,
                            });
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: Duration(milliseconds: 600),
                              curve: Curves.fastOutSlowIn,
                            );
                          }
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 114, 113, 113)),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 2.0,
            ),
          );
        }
      },
    );
  }
}
