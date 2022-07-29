import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';
import 'package:smart_home/model/NotificationTiles.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                decoration: BoxDecoration(
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Thông Báo",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
                              color: context.watch<ThemeProvider>().textColor
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 1000,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationTiles(
                      title: 'Cảnh Báo Đột Nhập',
                      subtitle: 'Phát hiện có người đột nhập',
                      enable: true,
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NotificationPage())),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
