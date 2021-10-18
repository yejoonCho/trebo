import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:provider/provider.dart';
import 'package:trebo/app_theme.dart';
import 'package:trebo/models/restaurant.dart';
import 'package:trebo/models/tourist_attraction.dart';
import 'package:trebo/screens/select/select_screen.dart';
import 'package:trebo/widgets/bottom_navigation_bar.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: currentPage,
      keepPage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final touristAttractions = Provider.of<List<TouristAttraction>>(context);
    final restaurants = Provider.of<List<Restaurant>>(context);

    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
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
              ],
            ),
            PageView(
              controller: _pageController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    _Title(text: '관광지'),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectScreeen(places: touristAttractions)));
                      },
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipPath(
                            clipper: _CardBackgroundClipper(),
                            child: Container(
                              height: screenHeight * 0.55,
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green.shade200,
                                    Colors.greenAccent.shade400
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 40,
                            bottom: 30,
                            child: Image.asset(
                              'assets/tourist_attraction.png',
                              height: screenHeight * 0.55,
                            )),
                        Positioned(
                          left: 60,
                          bottom: 30,
                          child: Text(
                            '추천을 받으려면 클릭하세요',
                            style: AppTheme.subHeading,
                          ),
                        )
                      ]),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    _Title(text: '음식'),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectScreeen(places: restaurants)));
                      },
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipPath(
                            clipper: _CardBackgroundClipper(),
                            child: Container(
                              height: screenHeight * 0.55,
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow.shade100,
                                    Colors.pink.shade200,
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 40,
                            bottom: 30,
                            child: Image.asset(
                              'assets/tourist_attraction.png',
                              height: screenHeight * 0.55,
                            )),
                        Positioned(
                          left: 60,
                          bottom: 30,
                          child: Text(
                            '추천을 받으려면 클릭하세요',
                            style: AppTheme.subHeading,
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ],
            )
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
                  Icons.menu,
                  color: Colors.blueGrey.shade600,
                  size: 25,
                ),
                onPressed: () {},
              ),
            ),
          ),
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

class _CardBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curveDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curveDistance);
    clippedPath.quadraticBezierTo(
        1, size.height - 1, 0 + curveDistance, size.height);
    clippedPath.lineTo(size.width - curveDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width,
        size.height - curveDistance);
    clippedPath.lineTo(size.width, 0 + curveDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0,
        size.width - curveDistance - 5, 0 + curveDistance / 3);
    clippedPath.lineTo(curveDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(
        1, (size.height * 0.30) + 10, 0, size.height * 0.4);
    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
