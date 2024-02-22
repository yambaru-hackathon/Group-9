import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

const String name = 'Dee';
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                    ],
                  ),
                  Icon(Icons.settings,size:35,),
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
                    radius: 40,
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
                  height: 400,
                  child: Card(
                    elevation: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text('買い物代行', style :TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    ),
                                    ),
                                ],
                              ),
                              Column(
                                children: [
                                  return buildSwitch();
                                ],
                              )
                                ],
                              ),
                        ),
                        Column(
                          children: [
                            buildSwitch(),
                          ],
                        ),
                            Row(
                              children: [
                                Text('____________________________________________________'),
                              ],
                            ),
                            
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
