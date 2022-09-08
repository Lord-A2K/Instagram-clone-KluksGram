import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kluksgram/components/shimmer_box.dart';
import 'package:kluksgram/models/user.dart';
import 'package:kluksgram/screens/feed_page/feed_discover.dart';
import 'package:kluksgram/screens/feed_page/feed_friends.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:kluksgram/utils/global_variable.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    User? _user = Provider.of<UserProvider>(context).getUser;
    TabController _tabController = TabController(length: 2, vsync: this);
    var size = MediaQuery.of(context).size;
    return _user == null
        ? ShimmerFeedPage()
        : Scaffold(
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  // body
                  Container(
                    width: size.width,
                    height: size.height,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        FeedFriends(),
                        FeedDiscover(),
                      ],
                    ),
                  ),

                  Positioned(
                      top: size.height * .06,
                      right: size.width * .06,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.message,
                          color: Colors.grey,
                          size: size.width * .06,
                        ),
                      )),

                  // Tabbar

                  Positioned(
                      top: size.height * .06,
                      left: size.width * .06,
                      child: Container(
                        height: size.height * .05,
                        width: size.width * .35,
                        child: TabBar(
                          indicator: CircleTabIndicator(
                              color: Colors.grey.withOpacity(.4), radius: 5),
                          controller: _tabController,
                          unselectedLabelColor: AppColors().primary,
                          labelColor: Colors.grey,
                          labelPadding: EdgeInsets.only(left: 2, right: 2),
                          tabs: [
                            const Tab(text: 'Friends'),
                            const Tab(text: 'Discover'),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class ShimmerFeedPage extends StatelessWidget {
  const ShimmerFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // body

            Positioned(
                top: size.height * .06,
                right: size.width * .06,
                child: ShimmerBox(
                  width: size.width * .06,
                  height: size.width * .06,
                )),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerBox(
                    height: postH * size.height * .76,
                    width: postW * size.width,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(width: size.width * .05),
                      ShimmerBox(width: size.width * .1, height: 50),
                      SizedBox(width: size.width * .05),
                      ShimmerBox(width: size.width * .75, height: 50),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ShimmerBox(width: size.width * .9, height: 15),
                  const SizedBox(height: 8),
                  ShimmerBox(width: size.width * .9, height: 15),
                  const SizedBox(height: 8),
                  ShimmerBox(width: size.width * .9, height: 15),
                  const SizedBox(height: 8),
                  ShimmerBox(width: size.width * .9, height: 15),
                ],
              ),
            ),

            // Tabbar

            Positioned(
              top: size.height * .06,
              left: size.width * .06,
              child: ShimmerBox(
                height: size.height * .05,
                width: size.width * .35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
