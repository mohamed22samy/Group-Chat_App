import 'package:chat_app/constans/color_pading.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore
    .instance; //variable to firebaseFireStore instance.(become "variable local").
late User
    signedInUser; //variable to user come from firebase,and this will give us the "email".(become "variable local").

class ChatScreen extends StatefulWidget {
  static const String screenRoute = "chat_screen"; //routes
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController =
      TextEditingController(); //to become text form free.
  final _auth = FirebaseAuth.instance; //variable to firebaseAuth instance.

  String? messageText; //this will give us the "messages".

  @override
  void initState() {
    //حطينا الفانكشن هنا عشان يتحدث تلقائي
    super.initState();
    getCurrentUser(); //function
  }

  void getCurrentUser() {
    //fanction to get current user.

    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e); //هتطبع الخطاء الي هيحصل وكتكتبه في الكونسول
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.socundColor,
        title: Row(children: [
          Image.asset(
            "images/logo.png",
            height: 25,
          ),
          const SizedBox(
            width: AppPading.kDefaultpading / 2,
          ),
          const Text("Chat App")
        ]),
        actions: [
          IconButton(
              onPressed: () {
                //Add here logout function
                _auth.signOut(); //signout order
                Navigator.pushNamed(
                    context, SigninScreen.screenRoute); //trans to back
              },
              icon: const Icon(Icons.close_outlined))
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, //لعمل مسافاه كبيره بين الكونتينارين
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MessageStreamBuilder(),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: Appcolor.socundColor, width: 2))),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                  child: TextField(
                controller: messageTextController, //as controller.
                onChanged: (value) {
                  messageText = value;
                },
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    hintText: "Write your message here...",
                    border: InputBorder.none),
              )),
              TextButton(
                  onPressed: () {
                    messageTextController.clear(); //to clean text form feild.
                    _fireStore.collection("messages").add({
                      //I used varable fireStore to call collection."massages".
                      // add ==> to add messages and users email.
                      "text": messageText, //variable value from textForm
                      "sender": signedInUser.email //User firebase value "email"
                      ,
                      "time": FieldValue.serverTimestamp(), // givem me time
                    });
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(
                        color: Appcolor.therdColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ))
            ]),
          )
        ],
      )),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //StreamBuilder to view data in chat_screen.consested of ==>Stram :  _fireStore.collection("massages").snapshots()
      stream: _fireStore
          .collection("messages")
          .orderBy("time")
          .snapshots(), //orderBy to give me time.
      builder: (context, snapshot) {
        List<MessageLine> messageWidgets = [];

        if (!snapshot.hasData) {
          //add here a spinner
          return const CircularProgressIndicator(
            color: Appcolor.therdColor,
            backgroundColor: Appcolor.socundColor,
           
            strokeWidth: 5,
          );
        }
        
        final messages =
            snapshot.data!.docs.reversed; //reversed becouse last message apper.
        for (var message in messages) {
          final messageText = message.get("text");
          final messageSender = message.get(
              "sender"); ////saved value email in messageSender variable.(Email Message Sender)
          final currentUser = signedInUser
              .email; //saved value email in currentUser variable.(Email Current User)

          final messageWidget = MessageLine(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender, //If CUU == SEE = True.
          );
          messageWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true, // becouse last message apper.
            padding: const EdgeInsets.symmetric(
                horizontal: AppPading.kDefaultpading / 2,
                vertical: AppPading.kDefaultpading),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  final String? sender;
  final String? text;
  final bool isMe;
  const MessageLine({super.key, this.sender, this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start, // curentUser == messageSender.
        children: [
          Text(
            "$sender",
            style: const TextStyle(fontSize: 12, color: Appcolor.socundColor),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe // curentUser == messageSender.
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe // curentUser == messageSender.
                ? Appcolor.therdColor
                : Appcolor
                    .socundColor, //If Value True Color Blue If Not Color Yellow.
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "$text",
                style: const TextStyle(fontSize: 15, color: Appcolor.white),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
