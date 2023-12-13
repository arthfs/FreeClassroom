import 'package:flutter/material.dart';

class Testt extends StatefulWidget {
  const Testt({Key? key}) : super(key: key);

  @override
  State<Testt> createState() => _TesttState();
}

class _TesttState extends State<Testt> {
  final SnackBar notif = const SnackBar(content: Text('Snackbar content'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(notif);
            },
            child: const Text('Show Snackbar'),
          ),
        ]),
        appBar: AppBar(),
      ),
    );
  }
}
