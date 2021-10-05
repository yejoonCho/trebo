import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final String message;
  CustomLoading({required this.message});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.grey.shade300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitDoubleBounce(
                  color: Colors.yellow.shade200,
                  size: 80,
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  style: GoogleFonts.lato(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )),
    );
  }
}
