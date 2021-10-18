import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/notifiers/like_notifier.dart';
import 'package:trebo/screens/detail/detail_screen.dart';
import 'package:trebo/screens/list/list_screen_app_bar.dart';
import 'package:trebo/screens/list/categories.dart';
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
            ListScreenAppBar(),
            Categories(),
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
