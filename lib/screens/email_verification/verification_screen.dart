import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero/cubits/localuser/localuser_cubit.dart';
import 'package:hero/screens/home/main_page.dart';
import 'package:provider/src/provider.dart';
import 'package:hero/models/models.dart' as myUser;

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState() {
    user = auth.currentUser!;

    if (user!.emailVerified == false) {
      user!.sendEmailVerification();
    }
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Checking account verification, one moment.'),
          ),
          ElevatedButton(
            onPressed: () => auth.signOut(),
            child: Text('Signout'),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user!.reload();
    if (user!.emailVerified) {
      timer!.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
    }
  }
}
