import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freeclassroom/main.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  User? newuser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((event) {}).onData((data) {
      // print(data);
      if ((data != null && newuser == null) ||
          (data == null && newuser != null)) {
        setState(() {
          newuser = data;
        });
      }
    });
    if (newuser == null) {
      return const MaterialApp(
          debugShowCheckedModeBanner: false, home: Login());
    } else {
      return const MyApp();
    }
  }
}
