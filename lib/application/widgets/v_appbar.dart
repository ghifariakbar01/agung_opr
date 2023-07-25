import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget VAppBar(String title, {Color? backgroundColor}) => AppBar(
      backgroundColor: backgroundColor ?? Palette.primaryColor,
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: Themes.customColor(FontWeight.bold, 18, Colors.white),
      ),
      elevation: 0,
    );
