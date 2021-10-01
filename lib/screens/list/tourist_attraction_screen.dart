import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/list_provider.dart';
import 'package:trebo/screens/details/detail_screen.dart';

class TouristAttractionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ListProvider>(context);
    return provider.isLoading
        ? CircularProgressIndicator()
        : Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildTouristAttraction(
                    context, index, provider.touristAttractions);
              },
            ),
          );
  }

  Widget _buildTouristAttraction(BuildContext context, int index,
      List<TouristAttraction> touristAttractions) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailScreen(touristAttraction: touristAttractions[index]),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(touristAttractions[index].imgUrl![0]),
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
