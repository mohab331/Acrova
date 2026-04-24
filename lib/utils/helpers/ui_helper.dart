import 'package:flutter/cupertino.dart';

class UiHelper {
  static double getLineHeight({
    required double fontSize,
    required double height,
  }) => height / fontSize;

}