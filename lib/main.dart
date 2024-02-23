// ignore_for_file: unused_import

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:group_9_birumanchu/pages/account_page.dart';
import 'package:group_9_birumanchu/pages/chat_page.dart';
import 'package:group_9_birumanchu/pages/map_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var currentIndex = 0;
  bool switch_value = true; 
  static const _screens = [
    MapPage(),
    ChatPage(),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack( // Stack ウィジェットでボトムナビゲーションバーをページの上に重ねる
        children: [
          _screens[currentIndex],
          Positioned( // ボトムナビゲーションバーの位置を指定
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              height: size.width * .155,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 221, 221),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  )
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNavItem(Icons.map_rounded, size),
                  buildNavItem(Icons.chat_bubble_outline, size),
                  buildNavItem(Icons.account_circle_rounded, size),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(IconData iconData, Size size) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = listOfIcons.indexOf(iconData);
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 1500),
            curve: Curves.fastLinearToSlowEaseIn,
            width: size.width * .128,
            height: currentIndex == listOfIcons.indexOf(iconData) ? size.width * .014 : 0,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          Icon(
            iconData,
            size: size.width * .076,
            color: currentIndex == listOfIcons.indexOf(iconData) ? Colors.blueAccent : Colors.black38,
          ),
          SizedBox(height: size.width * .0)
        ],
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.map_rounded,
    Icons.chat_bubble_outline,
    Icons.account_circle_rounded,
  ];

  Widget buildSwitch() =>Transform.scale(
    scale: 2,
    child: Switch.adaptive(
      activeColor: Colors.blue,
      activeTrackColor: Colors.blue,
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor:Colors.grey,
    value: switch_value, 
    onChanged:  (bool newValue) {
    setState(() {switch_value = newValue;}
    );}
    ),
  );
}