import 'package:flutter/material.dart';
import 'package:kluksgram/models/user.dart';
import 'package:kluksgram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatelessWidget {
  var snap;
  CommentCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    User? _user = Provider.of<UserProvider>(context).getUser;
    return _user == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(_user!.photoUrl),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Text(snap['text']),
                  ),
                ),
              ],
            ),
          );
  }
}
