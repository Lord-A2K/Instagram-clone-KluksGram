import 'package:flutter/material.dart';
import 'package:kluksgram/resources/firestore_method.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class LikeAnimation extends StatefulWidget {
  bool isLiked;
  final snap;
  String uid;
  LikeAnimation(
      {super.key,
      required this.isLiked,
      required this.snap,
      required this.uid});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    if (widget.isLiked) {
      controller.forward(from: 1);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FirestoreMethod()
            .likePost(widget.snap['postId'], widget.uid, widget.snap['likes']);
        if (widget.isLiked) {
          // disLike
          widget.isLiked = false;
          controller.reverse(from: .3);
        } else {
          // like
          widget.isLiked = true;
          controller.forward();
        }
      },
      child: Lottie.asset('assets/animations/like.json',
          height: 60, controller: controller),
    );
  }
}
