import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trebo/notifiers/like_notifier.dart';

class LikeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final likeNotifier = Provider.of<LikeNotifier>(context);
    final isUserLoggedIn = Provider.of<bool>(context);
    likeNotifier.init();
    return Container(
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
                final snackBar = SnackBar(
                  content: Text('찜 리스트에서 제거되었습니다.'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              })
          : IconButton(
              icon: Icon(Icons.favorite_border_outlined),
              color: Colors.black,
              onPressed: () {
                if (isUserLoggedIn) {
                  likeNotifier.toggleLike();
                  final snackBar = SnackBar(
                    content: Text('찜 리스트에 추가되었습니다.'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (!isUserLoggedIn) {
                  final snackBar = SnackBar(
                    content: Text('로그인이 필요한 서비스입니다.'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
    );
  }
}
