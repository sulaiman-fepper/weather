import 'package:flutter/material.dart';
import 'custom_color.dart';
import 'dimensions.dart';

class CustomStyle {

  static var headerStyle = const TextStyle(
    color: CustomColor.white,
    fontSize: 34,
    fontWeight: FontWeight.w500
  );

  static var headerTempStyle = const TextStyle(
      color: CustomColor.white,
      fontSize: 75,
      fontWeight: FontWeight.w100, height: 1
  );

  static var offWhiteStyle = const TextStyle(
      color: CustomColor.offWhite,
      fontSize: 20,
      fontWeight: FontWeight.w600
  );
  static var whiteStyle = const TextStyle(
      color: CustomColor.white,
      fontSize: 20,
      fontWeight: FontWeight.w600
  );

  static var bottomHeaderStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 18
  );
}