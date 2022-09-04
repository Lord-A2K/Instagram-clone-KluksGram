import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kluksgram/components/post_card.dart';
import 'package:lottie/lottie.dart';

class FeedFriends extends StatelessWidget {
  const FeedFriends({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Stack(
                children: [
                  Center(
                    child: PostCard(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  ),
                  index == 0
                      ? Center(
                          child: Lottie.asset('assets/animations/swipeup.json',
                              width: 150))
                      : Container()
                ],
              ),
            );
          }
          return Center(
            child: Text('disconnected'),
          );
        },
      )),
    );
  }
}
