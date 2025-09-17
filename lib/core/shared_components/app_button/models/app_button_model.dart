import 'package:flutter/material.dart';

class AppButtonModel {
  ButtonStyle? buttonStyle;
  EdgeInsets? padding;
  Widget child;
  Decoration? decoration;
  OutlinedBorder? shape;
  bool? enableButton;
  AppButtonModel({
    this.buttonStyle,
    required this.child,
    this.padding,
    this.enableButton,
    this.decoration,
    this.shape,
  });
}
