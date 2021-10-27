import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/repositories/location_repository.dart';
import 'package:trebo/screens/select_screen.dart';
import 'package:trebo/widgets/custom_drawer.dart';
import 'package:trebo/widgets/login_dialog.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final touristAttractions = Provider.of<List<TouristAttraction>>(context);
    final restaurants = Provider.of<List<Restaurant>>(context);
    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            _Background(
              width: screenWidth * 0.4,
              height: screenHeight,
            ),
            Column(
              children: [
                SizedBox(height: 20),
                _AppBar(),
                SizedBox(height: 20),
                _Title(text: 'Category'),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        _Card(
                          category: '관광지',
                          positionedImage: Positioned(
                              left: 20,
                              bottom: 120,
                              child:
                                  Image.asset('assets/tourist_attraction.png')),
                          places: touristAttractions,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          startColor: Colors.blueGrey.shade200,
                          endColor: Colors.yellowAccent.shade400,
                        ),
                        SizedBox(width: 50),
                        _Card(
                          category: '음식점',
                          positionedImage: Positioned(
                              left: -30,
                              bottom: 90,
                              child: Image.asset('assets/bibimbap.png',
                                  scale: 4.2)),
                          places: restaurants,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          startColor: Colors.cyan.shade200,
                          endColor: Colors.yellowAccent.shade400,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final double width, height;
  _Background({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        width: width,
        top: 0,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
          child: ColoredBox(
            color: Colors.grey.shade300,
          ),
        ));
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<bool>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isUserLoggedIn
              ? ClayContainer(
                  height: 50,
                  width: 50,
                  depth: 20,
                  borderRadius: 25,
                  curveType: CurveType.concave,
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.blueGrey.shade300, width: 2),
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
                )
              : Container(),
          isUserLoggedIn
              ? TextButton(
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      color: Colors.yellow.shade900,
                      fontSize: 24,
                    ),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                )
              : TextButton(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.yellow.shade900,
                      fontSize: 24,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => LoginDialog(),
                    );
                  },
                )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final text;
  _Title({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          letterSpacing: 4,
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String category;
  final positionedImage;
  final places;
  final screenWidth;
  final screenHeight;
  final startColor;
  final endColor;

  _Card(
      {required this.category,
      required this.positionedImage,
      required this.places,
      required this.screenWidth,
      required this.screenHeight,
      required this.startColor,
      required this.endColor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final _locationRepository = LocationRepository();
        Position position = await _locationRepository.getLocation();
        print(position.latitude);
        print(position.longitude);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectScreeen(position: position, places: places)));
      },
      child: Stack(children: [
        ClipPath(
          clipper: _CardBackgroundClipper(),
          child: Container(
            height: screenHeight * 0.6,
            width: screenWidth * 0.7,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [startColor, endColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),
        positionedImage,
        Positioned(
          left: 20,
          bottom: 20,
          child: Column(
            children: [
              Text(
                category,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '추천을 받으려면 클릭하세요',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class _CardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.2);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(0, size.height, curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(
        size.width, size.height, size.width, size.height - curveDistance);
    clippedPath.lineTo(size.width, size.height * 0.2 + curveDistance);
    clippedPath.quadraticBezierTo(size.width, size.height * 0.2,
        size.width - curveDistance, size.height * 0.2);
    clippedPath.lineTo(0 + curveDistance, size.height * 0.2);
    clippedPath.quadraticBezierTo(
        0, size.height * 0.2, 0, size.height * 0.2 + curveDistance);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
