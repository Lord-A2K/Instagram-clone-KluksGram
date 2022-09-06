import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kluksgram/components/loading_dialog.dart';
import 'package:kluksgram/providers/user_provider.dart';
import 'package:kluksgram/resources/auth_method.dart';
import 'package:kluksgram/resources/firestore_method.dart';
import 'package:kluksgram/utils/appcolors.dart';
import 'package:kluksgram/utils/global_variable.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import '../utils/utils.dart';

Uint8List? _image;

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void postImage(
    String uid,
    String username,
    String profileImage,
  ) async {
    try {
      showLoading(context);
      String res = await FirestoreMethod().uploadPost(
        _descriptionController.text,
        uid,
        username,
        _image!,
        profileImage,
      );
      Navigator.pop(context);
      if (res == 'success') {
        showSnackbar('Posted!', context);
        clearPost();
      } else {
        showSnackbar(res, context);
      }
    } catch (err) {
      showSnackbar(err.toString(), context);
    }
  }

  void selectImage() async {
    Uint8List? img;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors().primary.withOpacity(.5),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () async {
                      img = await pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                      setState(() {
                        _image = img;
                      });
                    },
                    child: const Text(
                      'Gallery',
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                    )),
                TextButton(
                    onPressed: () async {
                      img = await pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                      setState(() {
                        _image = img;
                      });
                    },
                    child: const Text(
                      'camera',
                      style: TextStyle(color: Colors.white60, fontSize: 20),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  void clearPost() {
    setState(() {
      _image = null;
      _descriptionController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of(context);
    var size = MediaQuery.of(context).size;
    return _userProvider == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AddPostAppBar(
                      callback: postImage,
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Container(
                      width: size.width * postW,
                      height: size.height * postH,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [Colors.transparent, Colors.black45]),
                          image: _image != null
                              ? DecorationImage(
                                  image: MemoryImage(_image!),
                                  fit: BoxFit.cover)
                              : null),
                      child: Stack(children: [
                        Center(
                          child: IconButton(
                              onPressed: selectImage,
                              icon: Icon(FontAwesomeIcons.upload)),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                height: size.height * .25,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center,
                                      colors: [
                                        Colors.black87,
                                        Colors.transparent
                                      ]),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(child: Container()),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * .05,
                                        ),
                                        Container(
                                            height: size.width * .15,
                                            width: size.width * .15,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  _userProvider
                                                      .getUser!.photoUrl),
                                            )),
                                        SizedBox(
                                          width: size.width * .02,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            _userProvider.getUser!.username,
                                            style: TextStyle(
                                              fontSize: size.width * .04,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: TextField(
                                        controller: _descriptionController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter caption here ...',
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        minLines: 1,
                                        maxLines: 4,
                                      ),
                                    ),
                                  ],
                                )))
                      ]),
                    ),
                    SizedBox(
                      height: size.height * .12,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

class AddPostAppBar extends StatelessWidget {
  var callback;
  AddPostAppBar({super.key, required this.callback});
  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of(context);
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * .045),
      width: size.width,
      height: size.height * .1,
      // color: Colors.red,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              AuthMethod().logoutUser();
            },
            icon: const Icon(
              FontAwesomeIcons.arrowLeft,
            ),
          ),
          SizedBox(
            width: size.width * .06,
          ),
          const Text(
            'Post to',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              if (_image == null) {
                showSnackbar('No Image Selected', context);
              } else {
                callback(
                    _userProvider.getUser!.uid,
                    _userProvider.getUser!.username,
                    _userProvider.getUser!.photoUrl);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors().accent,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Post',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
