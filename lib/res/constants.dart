import'package:flutter/material.dart';

import 'colors.dart';

EdgeInsets padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16);

TextStyle cardTitleStyle = const TextStyle(
color: Colors.white,
fontSize: 16,
fontWeight: FontWeight.bold,
);

final decoration  = BoxDecoration(
  color: MyColors.color,
  borderRadius: BorderRadius.circular(12),
  boxShadow: [
    BoxShadow(
      color: MyColors.color.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ],
);
