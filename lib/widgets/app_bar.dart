import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trebo/provider/google_sign_in.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize = Size(56, 56);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('TRRBO'),
      centerTitle: true,
      backgroundColor: Colors.black38,
      actions: [
        TextButton(
          child: Text(
            'Logout',
            style: GoogleFonts.lato(fontSize: 16, color: Colors.yellow),
          ),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();
            Navigator.pushNamed(context, '/login');
          },
        ),
        SizedBox(width: 15),
        ElevatedButton(
          child: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
