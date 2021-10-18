import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/notifiers/like_notifier.dart';

class LikeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final likeNotifier = Provider.of<LikeNotifier>(context);
    likeNotifier.init();
    return Positioned(
      right: 10,
      top: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: likeNotifier.isLiked
            ? IconButton(
                icon: Icon(Icons.favorite),
                color: Colors.red,
                onPressed: () {
                  likeNotifier.toggleLike();
                })
            : IconButton(
                icon: Icon(Icons.favorite_border_outlined),
                color: Colors.black,
                onPressed: () {
                  likeNotifier.toggleLike();
                },
              ),
      ),
    );
  }
}
