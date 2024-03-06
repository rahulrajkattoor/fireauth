import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../Firebase example/home.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey:  "AIzaSyA1gHyqlKV_Wt1XUWND8wUwj4uZ_Jfi26I",
          ///current key in google service json
          appId: "1:1060661389752:android:7bd9877417257b980d874d",
          ///mobilesdkappid in google service json
          messagingSenderId: '',
          projectId: "fireauth-bd9f3")
    ///projectid in google service json
  );


  runApp(phneVerify());

}
class phneVerify extends StatefulWidget{
  @override
  State<phneVerify> createState() => _phneVerifyState();
}

class _phneVerifyState extends State<phneVerify> {
  final phne_Controller=TextEditingController();
  final otp_Controller=TextEditingController();

  String userNumber='';

  FirebaseAuth auth=FirebaseAuth.instance;

  var otpFieldVissibility=false;
  var receivediD='';

  void verifyUserPhoneNumber(){
    auth.verifyPhoneNumber(
      phoneNumber: userNumber,
      verificationCompleted:(PhoneAuthCredential credential)async{
        await auth.signInWithCredential(credential).then((value)async{
          if(value.user!=null){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>home()),
                    );
          }
        });
      },
      verificationFailed:(FirebaseAuthException e){
        print(e.message);
      },
      codeSent:(String verificationId, int? resendToken){
        receivediD=verificationId;
        otpFieldVissibility=true;
        setState(() {

        });
      },
      codeAutoRetrievalTimeout:(String verificationId){},
    );
  }

  Future<void>verifyOTPCode()async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivediD,
      smsCode: otp_Controller.text,
    );
    await auth.signInWithCredential(credential).then((value)async{
      if(value.user!=null) {
       Navigator.push(
           context, MaterialPageRoute(builder: (context) => home()),
               );
      }
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Phone Authentication',
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IntlPhoneField(
                controller: phne_Controller,
                initialCountryCode: 'NG',
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  userNumber = val.completeNumber;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Visibility(
                visible: otpFieldVissibility,
                child: TextField(
                  controller: otp_Controller,
                  decoration: const InputDecoration(
                    hintText: 'OTP Code',
                    labelText: 'OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (otpFieldVissibility) {
                  verifyOTPCode();
                } else {
                  verifyUserPhoneNumber();
                }
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Text(
                otpFieldVissibility ? 'Login' : 'Verify',
              ),
            )
          ],
        ),
      ),
    );
  }
}