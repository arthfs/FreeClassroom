import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freeclassroom/wrapper.dart';
import 'firebase_options.dart';
import 'homepage.dart';

List<Map<String, String>> excluded = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Wrapper());
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                secondary: Colors.red,
                primary: Colors.red,
                seedColor: Colors.white)),
        home: const MyHomePage());
  }
}

const drawerItemColor = Colors.red;
