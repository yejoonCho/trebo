import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trebo/widgets/app_bar.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/drawer.dart';

class RecommendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.45,
            decoration: BoxDecoration(color: Color(0xFFF5CEB8)),
          ),
          SafeArea(
            child: Column(
              children: [
                Text(
                  "Recommendation !",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 36),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
