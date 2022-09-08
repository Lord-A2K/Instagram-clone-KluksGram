import 'package:blur/blur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kluksgram/components/comment_card.dart';
import 'package:kluksgram/models/user.dart';
import 'package:kluksgram/providers/user_provider.dart';
import 'package:kluksgram/resources/firestore_method.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:kluksgram/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CommentSection extends StatefulWidget {
  var snap;
  CommentSection({super.key, required this.snap});

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
    User? _user = Provider.of<UserProvider>(context).getUser;
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
          Positioned(
            left: (size.width / 2) - 35,
            top: -20,
            child: Container(
                width: 70,
                child: Lottie.asset('assets/animations/swipedown.json')),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 40, bottom: 80),
              child: Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.snap['postId'])
                        .collection('comments')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: (context, index) => Column(
                            children: [
                              CommentCard(
                                snap: snapshot
                                    .data!
                                    .docs[
                                        snapshot.data!.docs.length - index - 1]
                                    .data(),
                              ),
                              Divider(
                                color: Colors.black54,
                                
                                thickness: 2,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Text('No Comments'),
                        );
                      }
                    }),
              ),
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
                      backgroundImage: NetworkImage(_user!.photoUrl),
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
                          widget.snap['postId'],
                          _commentController.text,
                          _user.uid,
                          _user.username,
                          _user.photoUrl);
                      if (res == 'success') {
                        _commentController.text = '';
                        showSnackbar('comment posted.', context);
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
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
