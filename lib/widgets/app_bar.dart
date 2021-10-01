import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 65,
      ),
      child: Container(
        height: size.height * 0.1,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.sort_rounded),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.insights_rounded),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
