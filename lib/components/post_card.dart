import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kluksgram/components/comment_section.dart';
import 'package:kluksgram/components/like_animation.dart';
import 'package:kluksgram/providers/nav_provider.dart';
import 'package:kluksgram/providers/user_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../utils/global_variable.dart';
import '../utils/utils.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    NavProvider _navProvider = Provider.of(context, listen: false);
    User? _user = Provider.of<UserProvider>(context).getUser;
    return Container(
      width: size.width * postW,
      height: size.height * postH,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [Colors.transparent, Colors.black45]),
          image: DecorationImage(
              image: NetworkImage(widget.snap['postUrl']), fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: size.height * .3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black87, Colors.transparent]),
          ),
          child: Column(
            children: [
              Expanded(child: Container()),
              // user and like
              Row(
                children: [
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Container(
                      height: size.width * .15,
                      width: size.width * .15,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.snap['profileImage']),
                      )),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  // check if username is over 20 char, then clip
                  Container(
                    width: widget.snap['username'].toString().length > 20
                        ? 200
                        : null,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      widget.snap['username'],
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: size.width * .04,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 22,
                        right: 0,
                        child: Text(
                          widget.snap['likes'].length.toString(),
                        ),
                      ),
                      LikeAnimation(
                        isLiked: widget.snap['likes'].contains(_user!.uid),
                        snap: widget.snap,
                        uid: _user.uid,
                      ),
                    ],
                  ),
                ],
              ),

              // description
              Container(
                width: size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(widget.snap['description']),
              ),
              // Comment and date
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: TextStyle(color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        _navProvider.showTheBottomSheet(
                            context, CommentSection(snap: widget.snap));
                      },
                      child: Text(
                        ' view all cm',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
