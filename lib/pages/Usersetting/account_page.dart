// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:group_9_birumanchu/Reusable%20Widget/reusable_widget.dart';
import 'package:group_9_birumanchu/main.dart';
import 'package:group_9_birumanchu/pages/Usersetting/account_info_page.dart';
import 'package:group_9_birumanchu/pages/shopping_post/post_Inputform.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_card/responsive_card.dart';

const String name = 'Dee';
String des_date = '2/23/2024',
    des_city = '名護',
    req_shop = ' MaxValue, Aeon, SevenEleven, Lawson, Familymart ';
bool light = false;

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints(
      breakpoints: [
        Breakpoint(start: 0, end: 480, name: MOBILE),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pageTitle(),
              const Padding(
                padding: EdgeInsets.fromLTRB(2, 20, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfilePicture(
                      name: name,
                      radius: 45,
                      fontsize: 21,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      displayName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SwitchExample(),
            ],
          ),
        ),
      ),
    );
  }
}

class pageTitle extends StatelessWidget {
  const pageTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'アカウント',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 13, 13, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Accountinfo()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveCard(
      elevation: 3, //elevation
      titleGap: 3, // gap between title and leading
      bgColor: Colors.white,
      screenWidth: MediaQuery.of(context).size.width,
      // card background color // After this range of screen width it will work as a listtile
      action: Column(
        children: [
          SizedBox(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 1, 4, 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '買い物代行',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 3, 13, 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Switch(
                        // This bool value toggles the switch.
                        value: light,
                        activeColor: Colors.blue,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(
                            () {
                              light = value;
                              print(
                                  light); // change the mode insert to firebase
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Visibility(
            visible: light,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PostContent('日程', '宛先'),
                    PostContent(':', ':'),
                    PostContent(des_date, des_city),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      formConstantText('頼めるお店'),
                    ],
                  ),
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: shopList(req_shop),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text(
                          '変更',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return PostInputForm();
                              });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget PostContent(String content1, String content2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      formConstantText(content1),
      formConstantText(content2),
    ],
  );
}

Widget shopList(String shop_list) {
  return Row(
    children: [
      Flexible(
        child: Text(
          req_shop,
          softWrap: true,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
    ],
  );
}
