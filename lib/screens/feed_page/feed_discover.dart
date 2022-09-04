import 'package:flutter/material.dart';

class FeedDiscover extends StatelessWidget {
  const FeedDiscover({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: SafeArea(
        child: Container(),
      ),
    );
  }
}
