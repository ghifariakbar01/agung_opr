import 'package:agung_opr/application/routes/route_names.dart';
import 'package:agung_opr/style/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget VAppBar(BuildContext context, String title,
        {Widget? leading, Color? backgroundColor}) =>
    AppBar(
      backgroundColor: backgroundColor ?? Palette.primaryColor,
      automaticallyImplyLeading: leading != null ? false : true,
      leading: leading ?? null,
      title: Text(
        title,
        style: Themes.customColor(FontWeight.bold, 18, Colors.white),
      ),
      actions: [
        IconButton(
            onPressed: () => context.pushNamed(RouteNames.historyName),
            icon: Icon(
              Icons.history,
              color: Palette.yellow,
            ))
      ],
      elevation: 0,
    );
