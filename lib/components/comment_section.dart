import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:kluksgram/models/user.dart';
import 'package:kluksgram/providers/user_provider.dart';
import 'package:kluksgram/resources/firestore_method.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:provider/provider.dart';

class CommentSection extends StatefulWidget {
  String postId;
  CommentSection({super.key, required this.postId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<UserProvider>(context).getUser;
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .7,
      child: Stack(
        children: [
          // bg
          Blur(
            blur: 5,
            colorOpacity: .1,
            blurColor: Colors.transparent,
            child: Container(
              height: size.height * .7,
              width: size.width,
              // color: Colors.black45,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(_user.photoUrl),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Comment as ${_user.username}',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      minLines: 1,
                      maxLines: 4,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String res = await FirestoreMethod().postComment(
                          widget.postId,
                          _commentController.text,
                          _user.uid,
                          _user.username,
                          _user.photoUrl);
                    },
                    child: Container(
                      // height: 25,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors().accent,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text('Post'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
