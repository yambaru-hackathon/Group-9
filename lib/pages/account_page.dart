import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

const String name = 'Dee';
const String date = '2/23/2024';
const String des_city = 'nago';
const String req_shop = 'MaxValue, Aeon, SevenEleven';


bool switch_value = true; 
class AccountScreen extends StatelessWidget {
   const AccountScreen({Key? key}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('アカウント', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 13, 13, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                      Icon(Icons.settings,size:35,),
                    ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 20, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 ProfilePicture(
                    name: name,
                    radius: 45,
                    fontsize: 21,),
                ],
              ),
            ),
            Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      ),
                    ],
                  ),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                SizedBox(
                  width: 350,
                  height: 450,
                  child: Card(
                    elevation: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 13, 13, 0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('買い物代行', style :TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    ),
                                    ),
                                ],
                              ),
                              Spacer(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 13, 13, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                Icon(Icons.toggle_off_outlined,size:40,),
                              ],
                              ),
                            ),
                                ],
                              ),
                        ),
                            Row(
                              children: [
                                Text('____________________________________________________'),
                              ],
                            ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('日程　：　', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,),
                                  ),
                                  Text('宛先　：　', style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(date, style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 24,),),
                                  Text(des_city, style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 24,),),
                                ],
                              )
                            ],
                           ) ,
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('頼める店　', style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,),
                                    ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 200,
                                  child: TextField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                    border: OutlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.black) ),
                                    labelText: req_shop,),
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),  
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}



class buildSwitch extends StatelessWidget  {
  const buildSwitch({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 2,
        child: Switch.adaptive(
          activeColor: Colors.blue,
          activeTrackColor: Colors.blue,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor:Colors.grey,
        value: switch_value, 
        onChanged:  (newValue) => setState(newValue), 
        ),
      );
  }
  
  setState(bool newValue) {
    switch_value = newValue;
  }
}
