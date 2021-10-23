import 'dart:math';
import 'package:clay_containers/clay_containers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/screens/list_screen.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/custom_drawer.dart';
import 'package:trebo/widgets/custom_loading.dart';
import 'package:ml_linalg/linalg.dart' as linalg;
import 'package:trebo/widgets/login_dialog.dart';
import 'package:latlong2/latlong.dart';

class SelectScreeen extends StatefulWidget {
  final Position position;
  late List<dynamic> places;
  SelectScreeen({required this.position, required List<dynamic> places}) {
    if (places is List<TouristAttraction>) {
      List<TouristAttraction>.from(places);
    } else if (places is List<Restaurant>) {
      List<Restaurant>.from(places);
    }
    this.places = places;
  }
  @override
  _SelectScreeenState createState() => _SelectScreeenState();
}

class _SelectScreeenState extends State<SelectScreeen> {
  late int randomIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              SizedBox(height: 20),
              _AppBar(),
              SizedBox(height: 30),
              Text(
                '사진을 선택해주세요',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, _) {
                  randomIndex = Random().nextInt(widget.places.length);
                  return _buildItem(context, randomIndex);
                },
                itemCount: 4,
                shrinkWrap: true,
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  setState(() {
                    randomIndex = Random().nextInt(widget.places.length);
                  });
                },
                child: _RefreshIcon(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    int rand = Random().nextInt(widget.places[index].imgURLs.length);
    return GestureDetector(
      onTap: () {
        // 코사인 유사도 계산
        var temp = {};
        final vector1 = linalg.Vector.fromList(List<num>.from(
            widget.places[index].vectors[rand].values.toList()[0]));

        widget.places.forEach((touristAttraction) {
          touristAttraction.vectors.forEach((vec) {
            var vector2 =
                linalg.Vector.fromList(List<num>.from(vec.values.toList()[0]));
            double cosineSimilarity =
                vector1.dot(vector2) / (vector1.norm() * vector2.norm());
            temp[touristAttraction.id] = cosineSimilarity;
          });
        });
        // 정렬
        var sortedEntries = temp.entries.toList()
          ..sort((e1, e2) {
            var diff = e2.value.compareTo(e1.value);
            if (diff == 0) diff = e2.key.compareTo(e1.key);
            return diff;
          });
        temp = Map<dynamic, dynamic>.fromEntries(sortedEntries);
        print(temp);
        // 탑 5개 선정
        List<dynamic> topPlace = [];
        int limit = 0;
        temp.forEach((key, value) {
          if (limit < 5) topPlace.add(key);
          limit++;
        });
        print(topPlace);

        List<dynamic> result = widget.places
            .where((element) => topPlace.contains(element.id))
            .toList();

        print('완료');
        // 사용자와의 거리계산
        List<double> distances = [];
        result.forEach((place) {
          Distance distance = Distance();
          double km = distance.as(
              LengthUnit.Kilometer,
              LatLng(widget.position.latitude, widget.position.longitude),
              LatLng(place.latitude, place.longitude));
          distances.add(km);
        });
        print(distances);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ListScreen(places: result, distances: distances)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          widget.places[index].imgURLs[rand],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClayContainer(
            height: 50,
            width: 50,
            depth: 20,
            borderRadius: 25,
            curveType: CurveType.concave,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey.shade300, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.blueGrey.shade600,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          ClayContainer(
            height: 50,
            width: 50,
            depth: 20,
            borderRadius: 25,
            curveType: CurveType.concave,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey.shade300, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.blueGrey.shade600,
                  size: 25,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefreshIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Icon(
            Icons.refresh,
            size: 48,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.amber.shade300,
          border: Border.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 3,
          ),
          shape: BoxShape.circle,
        ));
  }
}
