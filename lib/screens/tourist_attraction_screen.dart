import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/provider/tourist_attraction_provider.dart';

class TouristAttractionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TouristAttractionProvider>(context);
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: provider.touristAttractions.length,
        itemBuilder: (context, index) {
          return _buildTouristAttraction(context, index);
        },
      ),
    );
  }

  Widget _buildTouristAttraction(BuildContext context, int index) {
    final provider = Provider.of<TouristAttractionProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
          height: 250,
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(
                        provider.touristAttractions[index].imgUrl!),
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
              Text(provider.touristAttractions[index].title!),
              Text(provider.touristAttractions[index].address!)
            ],
          )),
    );
  }
}
