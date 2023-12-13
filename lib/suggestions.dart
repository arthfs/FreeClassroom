import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freeclassroom/test.dart';
import 'custompage.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({super.key});

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  TextEditingController suggestionController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    suggestionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(Column(children: [
      const PageTitle("Suggestions"),
      TextField(
        controller: suggestionController,
        style: const TextStyle(),
        // cursorColor: ,
        decoration: const InputDecoration(counterStyle: TextStyle()),
        maxLines: 5,
        maxLength: 500,
      ),
      Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white)),
          child: TextButton(
              onPressed: () {
                //  List<String> email = [];
                if (suggestionController.text.length > 5) {
                  FirebaseFirestore.instance
                      .collection('email')
                      .get()
                      .then((value) {
                    for (var d in value.docs) {
                      // print("doc ${d.id}");

                      if (d.data()['uid'].toString().compareTo(
                              FirebaseAuth.instance.currentUser!.uid) ==
                          0) {
                        //print("succes ${d.id}");

                        FirebaseFirestore.instance
                            .collection('suggestion')
                            .doc(d.id)
                            .get()
                            .then((value) {
                          List suggestions = value.data()?['suggestion'] ?? [];
                          suggestions.add(suggestionController.text);
                          // print("List suggestions $suggestions");
                          FirebaseFirestore.instance
                              .collection('suggestion')
                              .doc(d.id)
                              .set({'suggestion': suggestions}).then((value) {
                            suggestionController.clear();
                            Navigator.of(context).pop();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                    content: Text(
                                        "Merci d' avoir fait cette suggestion"),
                                  );
                                });
                          });
                        });

                        break;
                      }
                    }
                  });
                } else {
                  //                    print("not valid");
                }
              },
              child: const Text(
                "soummettre",
                style: TextStyle(fontSize: 15, color: Colors.white),
              )))
    ]));
  }
}
