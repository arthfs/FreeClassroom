import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freeclassroom/note.dart';
import 'parametres.dart';
import 'suggestions.dart';
import 'test.dart';
import 'td.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';

class CustomPage extends StatefulWidget {
  final Widget page;
  const CustomPage(this.page, {super.key});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  TextEditingController raisonController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    raisonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          backgroundColor: Colors.white,
          width: 240,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                        },
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.home,
                                color: drawerItemColor,
                              ),
                              SizedBox(width: 40),
                              Text(
                                "Acceuil",
                                style: TextStyle(
                                    color: drawerItemColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ]))),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Td()));
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: drawerItemColor,
                          ),
                          SizedBox(width: 40),
                          Text(
                            "Horaire td",
                            style: TextStyle(
                                color: drawerItemColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const Note())));
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            color: drawerItemColor,
                          ),
                          SizedBox(width: 40),
                          Text(
                            "Mes notes",
                            style: TextStyle(
                                color: drawerItemColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Suggestion()));
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.report_outlined,
                            color: drawerItemColor,
                          ),
                          SizedBox(width: 40),
                          Text(
                            "Suggestions",
                            style: TextStyle(
                                color: drawerItemColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Parametres()));
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.settings,
                            color: drawerItemColor,
                          ),
                          SizedBox(width: 40),
                          Text(
                            "Paramètres",
                            style: TextStyle(
                                color: drawerItemColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Voulez vous vraiment vous supprimer votre compte ?",
                                style: TextStyle(color: drawerItemColor),
                              ),
                              content: SizedBox(
                                  height: 100,
                                  child: Column(children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        child: AlertDialog(
                                                            title: const Text(
                                                              "Suppresion compte",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            content: Container(
                                                                child: Column(
                                                              children: [
                                                                TextField(
                                                                  controller:
                                                                      raisonController,
                                                                  maxLines: 3,
                                                                  decoration: const InputDecoration(
                                                                      labelText:
                                                                          'Raison(s)'),
                                                                  maxLength:
                                                                      500,
                                                                ),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'users')
                                                                          .doc(FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .uid)
                                                                          .get()
                                                                          .then(
                                                                              (value) async {
                                                                        await FirebaseFirestore
                                                                            .instance
                                                                            .collection('delete')
                                                                            .add({
                                                                          'nom':
                                                                              value.data()?['nom'],
                                                                          'prenom':
                                                                              value.data()?['prenom'],
                                                                          'raison':
                                                                              raisonController.text
                                                                        }).then((value) async {
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection('users')
                                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                              .delete();
                                                                        }).then((value) async {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          raisonController
                                                                              .clear();
                                                                          try {
                                                                            await FirebaseAuth.instance.currentUser!.delete();
                                                                          } on FirebaseAuthException catch (e) {
                                                                            print(e);
                                                                          }
                                                                        });
                                                                      });
                                                                    },
                                                                    child: const Text(
                                                                        "Terminer"))
                                                              ],
                                                            ))),
                                                      );
                                                    });
                                                // await FirebaseAuth.instance
                                                //   .signOut();
                                                //    .then((value) =>
                                                //      setState(() {}));
                                              },
                                              child: const Text("Oui")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Non"))
                                        ])
                                  ])),
                            );
                          });
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.no_accounts_outlined,
                              color: drawerItemColor),
                          SizedBox(width: 40),
                          Text(
                            "Supprimer mon compte",
                            style: TextStyle(
                                color: drawerItemColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Column(
                              children: [
                                const Text(
                                  "Termes et conditions",
                                  style: TextStyle(fontSize: 30),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    height: 600,
                                    child: ListView(
                                      children: [Text(terms)],
                                    ))
                              ],
                            ));
                          });
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.privacy_tip_outlined,
                            color: drawerItemColor,
                          ),
                          SizedBox(width: 30),
                          Text(
                            "Termes et conditions",
                            style: TextStyle(
                                color: drawerItemColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Column(
                              children: [
                                const Text("Politique de confidentialié",
                                    style: TextStyle(fontSize: 30),
                                    textAlign: TextAlign.center),
                                Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    height: 600,
                                    child: ListView(
                                      children: [Text(privacypolicy)],
                                    ))
                              ],
                            ));
                          });
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.lock, color: drawerItemColor),
                          SizedBox(width: 30),
                          Text(
                            "Politique de confidentialié",
                            style: TextStyle(
                                color: drawerItemColor,
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Voulez vous vraiment vous déconnecter ?",
                                style: TextStyle(color: drawerItemColor),
                              ),
                              content: SizedBox(
                                  height: 100,
                                  child: Column(children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                //    .then((value) =>
                                                //      setState(() {}));
                                              },
                                              child: const Text("Oui")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Non"))
                                        ])
                                  ])),
                            );
                          });
                    },
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.logout, color: drawerItemColor),
                          SizedBox(width: 40),
                          Text(
                            "Déconnection",
                            style: TextStyle(
                                color: drawerItemColor,
                                fontWeight: FontWeight.bold),
                          )
                        ]))
              ])),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            "FreeClassrooms",
            style: TextStyle(color: Colors.white),
          )),
      body: widget.page,
    );
  }
}
