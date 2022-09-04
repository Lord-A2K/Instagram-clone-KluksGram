import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:kluksgram/screens/add_post_page.dart';
import 'package:kluksgram/screens/feed_page.dart';

const webScreenSize = 600;

const screenItems = [
  FeedPage(),
  // Center(child: Text('2'), key: ValueKey(1)),
  Center(child: Text('2'), key: ValueKey(1)),
  AddPostPage(key: ValueKey(2)),
  Center(child: Text('4'), key: ValueKey(3)),
  Center(child: Text('5'), key: ValueKey(4))
];

const postW = .95;
const postH = .75;
