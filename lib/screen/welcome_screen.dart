import 'package:chat_app/screen/regisration_screen.dart';
import 'package:chat_app/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/my_button.dart';
class WelcomeScreen extends StatefulWidget {

  static const String ScreenRoute='welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:24),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          mainAxisAlignment:MainAxisAlignment.center,
          
          children: [
        Container(
          height:200,
          child: Image.asset("images/chat.png")),
          Text("message me ",
          textAlign:TextAlign.center,
          style:TextStyle(
            color:Color(0xff2e386b),
            fontSize:40,
            fontWeight:FontWeight.w900)),
            SizedBox(height:30),
            MyButton(
              color:Colors.yellow[900]!,
              title:"sign in",
              onpressed:(){
                Navigator.pushNamed(context, SignInScreen.screenRoute);
              },
            ),
            MyButton(
              color:Colors.blue[800]!,
               title: 'Signup',
                onpressed:(){

                Navigator.pushNamed(context, RegisrationScreen.screenRoute);
                }
 ,)

        ],),
      ),
    );
  }
}

