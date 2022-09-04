import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showLoading(ctx) {
  showDialog(
      context: ctx,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Lottie.asset('assets/animations/loading.json')),
        );
      });
}
