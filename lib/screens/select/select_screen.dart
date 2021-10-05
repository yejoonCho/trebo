import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/provider/random_image_provider.dart';
import 'package:trebo/provider/similar_list_provider.dart';
import 'package:trebo/screens/list/list_screen.dart';
import 'package:trebo/screens/login_screen.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/custom_loading.dart';

class SelectScreeen extends StatelessWidget {
  final title;
  SelectScreeen({this.title});
  @override
  Widget build(BuildContext context) {
    final randomImageProvider = Provider.of<RandomImageProvider>(context);
    final similarListProvider = Provider.of<SimilarListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: randomImageProvider.isLoading || similarListProvider.isLoading
          ? CustomLoading(message: '사진을 가져오는 중입니다.')
          : Container(
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) => _buildItem(context, index),
                  itemCount: 10,
                ),
              ),
            ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final randomImageProvider = Provider.of<RandomImageProvider>(context);
    final similarListProvider = Provider.of<SimilarListProvider>(context);
    return GestureDetector(
      onTap: () async {
        await similarListProvider
            .calculateSimilarity(randomImageProvider.randomImg[index]);
        await similarListProvider.getData();
        await similarListProvider.downloadImage();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListScreen()));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          randomImageProvider.randomURL[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
