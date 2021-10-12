import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/screens/detail/detail_screen.dart';
import 'package:trebo/screens/list/list_screen.dart';
import 'package:trebo/screens/select/select_screen.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/drawer.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: CustomDrawer(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        appBar: AppBar(
          title: Text("Recommend",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: size.height,
          color: Colors.grey.shade300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getExpanded(context, 'beer', 'Bars', '42 place'),
                    getExpanded(context, 'fast-food', 'Restaurant', '15 place'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getExpanded(context, 'cafe', 'Cafe', '33 place'),
                    getExpanded(
                        context, 'tracking', 'touristAttraction', '23 place'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getExpanded(context, 'dining', 'Hotel', '33 place'),
                    getExpanded(context, 'cuisine', 'Festival', '23 place'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Expanded getExpanded(
      BuildContext context, String image, String mainText, String subText) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/$image.png', height: 80),
              SizedBox(height: 5),
              Text("$mainText",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 5),
              Text(
                "$subText",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              boxShadow: [BoxShadow()]),
        ),
        onTap: () {
          final touristAttractions =
              Provider.of<List<TouristAttraction>>(context, listen: false);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SelectScreeen(touristAttractions: touristAttractions)));
        },
      ),
    );
  }
}
