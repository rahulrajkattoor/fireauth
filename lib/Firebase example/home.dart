
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Firebase helper.dart';
import 'login.dart';

class home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ElevatedButton(onPressed: (){
                FireBaseHelper().logout().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>login())));
              }, child: Text("Logout")),
            )
          ],
        ),
      ),
    );
  }

}