import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/random_image_provider.dart';
import 'package:trebo/provider/similar_list_provider.dart';
import 'package:trebo/screens/list/list_loading.dart';
import 'package:trebo/screens/list/list_screen.dart';
import 'package:trebo/screens/login_screen.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/custom_loading.dart';
import 'package:ml_linalg/linalg.dart' as linalg;

class SelectScreeen extends StatefulWidget {
  final List<TouristAttraction> touristAttractions;
  SelectScreeen({required this.touristAttractions});
  @override
  _SelectScreeenState createState() => _SelectScreeenState();
}

class _SelectScreeenState extends State<SelectScreeen> {
  late int randomIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('선택'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                randomIndex =
                    Random().nextInt(widget.touristAttractions.length);
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, _) {
              randomIndex = Random().nextInt(widget.touristAttractions.length);
              return _buildItem(context, randomIndex);
            },
            itemCount: 10,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    int rand =
        Random().nextInt(widget.touristAttractions[index].imgURLs.length);
    return GestureDetector(
      onTap: () {
        // 코사인 유사도 계산
        var temp = {};
        final vector1 = linalg.Vector.fromList(List<num>.from(
            widget.touristAttractions[index].vectors[rand].values.toList()[0]));

        widget.touristAttractions.forEach((touristAttraction) {
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

        List<TouristAttraction> result = widget.touristAttractions
            .where((element) => topPlace.contains(element.id))
            .toList();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListScreen(touristAttractions: result)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          widget.touristAttractions[index].imgURLs[rand],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
