import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Firebase helper.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(home: register(),));
}

class register extends StatefulWidget {
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  var email_controller = TextEditingController();
  var pass_controller= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: TextField(
              controller: email_controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextField(
              controller: pass_controller,
              decoration: InputDecoration(
                  hintText: "password", border: OutlineInputBorder()),
            ),),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {
              String email =email_controller.text.trim();
              String pass=pass_controller.text.trim();

              FireBaseHelper().registerUser(email:email,pwd:pass).then((result){
                if(result==null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                }
              });
            }, child: Text("Register")),
          )

        ],
      ),
    );
  }
}