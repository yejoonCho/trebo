import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        top: 5,
        bottom: 5,
        right: 15,
      ),
      child: Container(
          height: size.height * 0.05,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildCategory(context, index);
            },
          )),
    );
  }

  Widget _buildCategory(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: selectedCategoryIndex == index
                ? Colors.amber
                : Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text('similarity',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selectedCategoryIndex == index
                        ? Colors.black
                        : Colors.black)),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          selectedCategoryIndex = index;
        });
      },
    );
  }
}
