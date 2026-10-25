import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRoute='signin_screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  bool showloading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white, 
      body:ModalProgressHUD(inAsyncCall: showloading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:24),
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Container(
              height:200,
              child: Image.asset("images/chat.png")),
              SizedBox(height:50),
              TextField(
               keyboardType:TextInputType.emailAddress,
                textAlign:TextAlign.center,
                onChanged:(value){
                  email=value;
                },
                decoration:InputDecoration(
                  hintText:"enter your email",
                  contentPadding:EdgeInsets.symmetric(
                    vertical:10,
                    horizontal:20
                  ),
                  border:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.orange,width:1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.blue,width:2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              ),
              SizedBox(height:20,),
               TextField(
                 obscureText:true,
                textAlign:TextAlign.center,
                onChanged:(value){
                  password=value;
                },
                decoration:InputDecoration(
                  hintText:"enter your password",
                  contentPadding:EdgeInsets.symmetric(
                    vertical:10,
                    horizontal:20
                  ),
                  border:OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.orange,width:1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide:BorderSide(color:Colors.blue,width:2),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              ),
              SizedBox(height:10,),
              MyButton(
                color: Colors.yellow[900]!,
                 title: "signin",
                  onpressed: ()async{
                    setState(() {
                      showloading=true;
                    });
                    try {
                      final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(user != null){
                      Navigator.pushNamed(context, ChatScreen.ScreenRoute);
                      setState(() {
                        showloading=false;
                      });
                    }
                    } catch (e) {
                      print(e);
                    }
                  })
            ],
          ),
        ),
      )
         );
  }
}