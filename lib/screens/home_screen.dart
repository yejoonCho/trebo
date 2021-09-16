import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trebo/provider/weather_provider.dart';
import 'package:trebo/widgets/app_bar.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';
import 'package:trebo/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: weatherProvider.isLoading
          ? _loadingWidget()
          : Container(
              alignment: Alignment.center,
              color: Colors.blueGrey.shade900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Profile', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 32),
                  CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!)),
                  SizedBox(height: 8),
                  Text(
                    'Name: ' + user.displayName!,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ' + user.email!,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  ElevatedButton(
                    child: Text('press me'),
                    onPressed: () {
                      print(weatherProvider.weather!.description);
                    },
                  )
                ],
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
