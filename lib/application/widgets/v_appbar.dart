import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget VAppBar(String title) => AppBar(
      backgroundColor: Palette.primaryColor,
      title: Text(
        title,
        style: Themes.customColor(FontWeight.bold, 18, Colors.white),
      ),
      elevation: 0,
    );
