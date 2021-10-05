import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/similar_list_provider.dart';
import 'package:trebo/screens/details/detail_screen.dart';
import 'package:trebo/screens/list/list_screen_app_bar.dart';
import 'package:trebo/screens/list/categories.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    final similarListProvider = Provider.of<SimilarListProvider>(context);
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildTouristAttraction(
                      context, index, similarListProvider.touristAttractions);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTouristAttraction(BuildContext context, int index,
      List<TouristAttraction> touristAttractions) {
    Size size = MediaQuery.of(context).size;
    final similarListProvider = Provider.of<SimilarListProvider>(context);

    return GestureDetector(
      onTap: () async {
        await similarListProvider.downloadOneImage(touristAttractions[index]);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailScreen(touristAttraction: touristAttractions[index]),
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
                      image: NetworkImage(similarListProvider
                          .touristAttractions[index].downloadedURL![0]),
                      height: 180,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.favorite_border_rounded),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                    ),
                  )
                ]),
                Text(
                  touristAttractions[index].title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  touristAttractions[index].address!,
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
