import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/notifiers/like_notifier.dart';
import 'package:trebo/screens/detail_screen.dart';
import 'package:trebo/widgets/like_button.dart';

class ListScreen extends StatefulWidget {
  late List<dynamic> places;
  ListScreen({required places}) {
    if (places is List<TouristAttraction>) {
      List<TouristAttraction>.from(places);
    } else if (places is List<Restaurant>) {
      List<Restaurant>.from(places);
    }
    this.places = places;
  }
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        color: Colors.grey.shade300,
        child: Column(
          children: [
            SizedBox(height: top),
            _AppBar(),
            _Categories(),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: widget.places.length,
                itemBuilder: (context, index) {
                  return _buildItem(context, index, widget.places);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, List<dynamic> places) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(place: places[index]),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(places[index].imgURLs[0]),
                      height: 180,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ChangeNotifierProvider.value(
                    value: LikeNotifier(place: places[index]),
                    child: LikeButton(),
                  )
                ]),
                Text(
                  places[index].title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  places[index].address,
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(0.6)),
                ),
                SizedBox(height: 10)
              ],
            )),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Container(
        height: size.height * 0.08,
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
                    child: Icon(Icons.arrow_back),
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

class _Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<_Categories> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 5,
        top: 5,
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
