import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/provider/google_sign_in.dart';
import 'package:trebo/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
            Colors.black.withOpacity(0.9),
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.4),
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find the best locations for you",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    height: 1.1),
              ),
              SizedBox(height: 30),
              Text(
                "Let us find you an event for your interest",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 35,
                    fontWeight: FontWeight.w100),
              ),
              SizedBox(height: 120),
              SocialLoginButton(
                  image: Image.asset('assets/flogo.png'),
                  text: Text('Login with Facebook',
                      style: TextStyle(color: Colors.black87, fontSize: 20)),
                  color: Color(0xFF334D92),
                  onpressed: () {}),
              SizedBox(height: 30),
              SocialLoginButton(
                color: Colors.white,
                image: Image.asset('assets/glogo.png'),
                text: Text('Login with Google',
                    style: TextStyle(color: Colors.black87, fontSize: 20)),
                onpressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  late Widget image;
  late Widget text;
  late Color color;
  late VoidCallback onpressed;

  SocialLoginButton(
      {required this.image,
      required this.text,
      required this.color,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            image,
            text,
            Opacity(
              opacity: 0,
              child: Image.asset('assets/glogo.png'),
            )
          ],
        ),
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
            primary: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: Size(160, 60)));
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
