import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kluksgram/models/user.dart';
import 'package:kluksgram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatelessWidget {
  var snap;
  CommentCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    User? _user = Provider.of<UserProvider>(context).getUser;
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        // color: Colors.black.withOpacity(.4),
        borderRadius: BorderRadius.circular(10),
        // border: Border(bottom: BorderSide(color: Colors.grey, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_user!.photoUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      snap['username'],
                      style: TextStyle(
                        fontSize: size.width * .035,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: size.width * .6,
                    height: snap['text'].length > 100 ? size.height * .1 : null,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Text(
                          snap['text'],
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              DateFormat.yMMMd().format(snap['datePublished'].toDate()),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          )
        ],
      ),
    );
  }
}
