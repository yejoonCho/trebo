import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/provider/select_provider.dart';
import 'package:trebo/provider/list_provider.dart';
import 'package:trebo/screens/list/list_screen.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';

class SelectScreeen extends StatelessWidget {
  final title;
  SelectScreeen({this.title});
  @override
  Widget build(BuildContext context) {
    final selectProvider = Provider.of<SelectProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: selectProvider.isLoading
          ? _loadingWidget()
          : Container(
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
                  itemCount: 10,
                ),
              ),
            ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final selectProvider = Provider.of<SelectProvider>(context);
    final listProvider = Provider.of<ListProvider>(context);
    return GestureDetector(
      onTap: () async {
        await listProvider.fetch();
        listProvider.cosineSimilarity(selectProvider.randomImg[index] + '.jpg');
        await listProvider.getData();
        await listProvider.downloadImage();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListScreen()));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          selectProvider.randomURL[index],
          fit: BoxFit.cover,
        ),
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
