import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Log In',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 40),
          SocialLoginButton(
            image: Image.asset('assets/glogo.png'),
            text: Text(
              '구글 로그인',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            color: Colors.green.shade200,
            onpressed: () async {
              final googleSignIn = GoogleSignIn();
              final googleUser = await googleSignIn.signIn();
              if (googleUser == null) return;

              final googleAuth = await googleUser.authentication;
              final credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken);

              await FirebaseAuth.instance.signInWithCredential(credential);
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 30),
        ]),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final Widget image;
  final Widget text;
  final Color color;
  final VoidCallback onpressed;

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
