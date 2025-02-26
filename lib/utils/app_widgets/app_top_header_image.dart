import 'package:flutter/material.dart';
import '../decoration_and_assets/images.dart';

Widget appTopHeaderImage({String? image, double? top}) => Positioned(
      top: top ?? -200,
      left: -100,
      right: -100,
      child: Container(
        alignment: Alignment.topCenter,
        child: Image.asset(
          image ?? backgroundGrid,
        ),
      ),
    );
