import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';

class NotificationTiles extends StatelessWidget {
  final String title, subtitle;
  final Function onTap;
  final bool enable;
  const NotificationTiles({
    Key? key, required this.title, required this.subtitle, required this.onTap, required this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 50.0,
          width: 50.0,
          padding: EdgeInsets.all(200),
          decoration:  BoxDecoration(
            color:  context.watch<ThemeProvider>().iconNotiCard,
              image: const DecorationImage(image: AssetImage('assets/images/anti-theft.png',), fit: BoxFit.cover,))),
      title: Text(title, style: const TextStyle(color: Colors.deepOrange)),
      subtitle: Text(subtitle,
          style:  TextStyle( color: context.watch<ThemeProvider>().textColor)),
      onTap: (){
      },
      enabled: enable,
    );
  }
}