import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/tourist_attraction_provider.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';

class SelectScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) => _buildItem(context, index),
            itemCount: 5,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final provider = Provider.of<TouristAttractionProvider>(context);
    int rand = Random().nextInt(provider.touristAttractions.length);
    provider.downloadImage(rand);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        provider.touristAttractions[rand].imgUrl![0],
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), Text('정보를 가져오는 중')],
      ),
    );
  }
}
