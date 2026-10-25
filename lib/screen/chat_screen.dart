import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
  final _firestore = FirebaseFirestore.instance;
  late User sginedInUser; //email

class ChatScreen extends StatefulWidget {
  static const String ScreenRoute = 'chat_screen';
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final meassagetextcontroller=TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageTest; //message
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        sginedInUser = user;
        print(sginedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages()async{
  //   final messages = await _firestore.collection('messages').get();
  //   for(var message in messages.docs){
  //             print(message.data());
  //   }
  // }
  // void messageSteam() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset("images/chat.png", height: 30),
            SizedBox(width: 10),

            Text("message me", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
             // messageSteam();
              _auth.signOut();
             Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           MessageStreamBuilder(),
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.orange, width: 2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: meassagetextcontroller,
                      onChanged: (value) {
                        messageTest = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: "write your message......",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      meassagetextcontroller.clear();
                      _firestore.collection('messages').add({
                        'sender': sginedInUser.email,
                        'text': messageTest,
                        'time':FieldValue.serverTimestamp(),
                      });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
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
class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('time').snapshots(),
              builder: (context, snapshot) {
                // 1. التعامل الصحيح مع حالة التحميل
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow[900],
                    ),
                  );
                }
                List<Messageline> messageWidgets = [];
                final messages = snapshot.data!.docs.reversed;
                for (var message in messages) {
                  final data = message.data() as Map<String, dynamic>?;

                  if (data != null) {
                    final messagetext =
                        data.containsKey('text') && data['text'] != null
                        ? data['text']
                        : '';
                    final messagesender =
                        data.containsKey('sender') && data['sender'] != null
                        ? data['sender']
                        : 'Unknown';
                        final currentUser=sginedInUser.email; 
                    final messageWidget = Messageline(text: messagetext, sender: messagesender,isME:messagesender==currentUser,);
                    messageWidgets.add(messageWidget);
                  }
                }
                return Expanded(
                  child: ListView(
                    reverse:true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: messageWidgets,
                  ),
                );
              },
            );
            // StreamBuilder<QuerySnapshot>(
            //   stream: _firestore.collection('messages').snapshots(),
            //   builder: (context, snapshot) {
            //     List<Text> messageWidgets = [];
            //     if(!snapshot.hasData){return Center(child:CircularProgressIndicator(),);}
            //     final messages=snapshot.data!.docs;
            //     for (var message in messages){
            //       final messagetext=message.get('text');
            //       final messagesender=message.get('sender');
            //       final messageWidget=Text(' $messagetext - $messagesender');
            //       messageWidgets.add(messageWidget);
            //     }
            //     return Column(children: messageWidgets);
            //   },
            // ),
  }
}
class Messageline extends StatelessWidget {
  const Messageline({super.key, required this.text, required this.sender, required this.isME});
  final String text;
  final String sender;
  final bool isME;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isME? CrossAxisAlignment.end :CrossAxisAlignment.start,
        children: [
          Text('$sender',style:TextStyle(fontSize:12,color:Colors.yellow[900]),),
          Material(
            elevation:5,
            borderRadius:isME? BorderRadius.only(
                   topLeft:Radius.circular(30),
                   bottomLeft:Radius.circular(30),
                   bottomRight:Radius.circular(30)) 
                   :
                    BorderRadius.only(
                   topRight:Radius.circular(30),
                   bottomLeft:Radius.circular(30),
                   bottomRight:Radius.circular(30)),
            color:isME ? Colors.blue[800]: Colors.white,
          
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10,vertical:10),
              child: Text(' $text ', style: TextStyle(fontSize: 25,color: isME ? Colors.white : Colors.black45)),
            ),
          ),
        ],
      ),
    );
  }
}
