import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'custompage.dart';

double fieldsMargin = 20, fieldsWidth = 200;

class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  bool visiblePassword = false, visibleConfirmPassword = false;
  int complexity = -1;
  Color complexityColor = Colors.white;

  TextEditingController emailController = TextEditingController(),
      nomController = TextEditingController(),
      prenomController = TextEditingController(),
      faculteController = TextEditingController(),
      optionController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    faculteController.dispose();
    optionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (complexity == 4) {
      complexityColor = Colors.green;
    } else if (complexity == 1 || complexity == 2) {
      complexityColor = Colors.red;
    } else if (complexity == 3) {
      complexityColor = Colors.orange;
    }

    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, user) {
          nomController.text = user.data?['nom'];
          prenomController.text = user.data?['prenom'];
          faculteController.text = user.data?['faculte'];
          optionController.text = user.data?['option'];
          emailController.text = FirebaseAuth.instance.currentUser!.email!;
          return CustomPage(Column(children: [
            const Text(
              "Paramètres",
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: Center(
                    child: SizedBox(
                        height: 600,
                        //   width: 200,
                        child: ListView(children: [
                          Container(
                              margin: EdgeInsets.only(bottom: fieldsMargin),
                              width: fieldsWidth,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.length < 2) {
                                    return 'Entrer un nom valide';
                                  }
                                  return null;
                                },
                                controller: nomController,
                                decoration: const InputDecoration(
                                  label: Text('Nom'),
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: fieldsMargin),
                              //  height: 40,
                              decoration: const BoxDecoration(),
                              width: fieldsWidth,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: prenomController,
                                decoration: const InputDecoration(
                                  label: Text('Prénom'),
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 2) {
                                    return 'Entrer un prénom valide';
                                  }
                                  return null;
                                },
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: fieldsMargin),
                              width: fieldsWidth,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: faculteController,
                                decoration: const InputDecoration(
                                  label: Text('Faculté'),
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 4) {
                                    return 'Entrer une faculté valide';
                                  }
                                  return null;
                                },
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: fieldsMargin),
                              width: fieldsWidth,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: optionController,
                                decoration: const InputDecoration(
                                  label: Text('Option'),
                                ),
                                validator: (value) {
                                  if (value == null || value.length < 10) {
                                    return 'Entrer une option valide';
                                  }
                                  return null;
                                },
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: fieldsMargin),
                              width: fieldsWidth,
                              child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onEditingComplete: () {},
                                  validator: (tempemail) {
                                    if (tempemail!.isEmpty) {
                                      return "Entrer un email";
                                    }

                                    const pattern =
                                        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
                                    final regex = RegExp(pattern);
                                    if (!regex.hasMatch(tempemail)) {
                                      return "Entrer un email valide";
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    label: Text("Email"),
                                  ))),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: fieldsMargin),
                            width: fieldsWidth,
                            child: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return const AlertDialog();
                                      }));
                                },
                                child: const Text(
                                  "Changer mot de passe",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))

                            /*Column(children: [
                                      TextFormField(
                                          controller: passwordController,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Entrer votre mot de passe';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              complexity =
                                                  evalComplexity(value);
                                              print(complexity);
                                            });
                                          },
                                          obscureText: !visiblePassword,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: Icon(visiblePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  visiblePassword =
                                                      !visiblePassword;
                                                });
                                              },
                                            ),
                                            label: const Text('Mot de passe'),
                                          )),
                                      if (complexity > -1)
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: List.generate(
                                              4,
                                              (index) => Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: const EdgeInsets.only(
                                                      top: 10, right: 5),
                                                  height: 5,
                                                  color: complexityColor,
                                                  width: fieldsWidth / 5),
                                            )),
                                      if (complexity > -1)
                                        Container(
                                            width: fieldsWidth,
                                            child: Text(
                                              complexity == 4
                                                  ? 'Excellent'
                                                  : complexity == 3
                                                      ? 'Moyen'
                                                      : 'Faible',
                                              textAlign: TextAlign.start,
                                            ))
                                    ])*/
                            ,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                              onPressed: () async {
                                if (emailController.text
                                        .split('@')[1]
                                        .compareTo("uniq.edu") !=
                                    0) {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              "Vous devez être un étudiant de l'université Quisqueya",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ));
                                      });
                                } else {
                                  try {
                                    if (emailController.text !=
                                        FirebaseAuth
                                            .instance.currentUser?.email) {
                                      await FirebaseAuth.instance.currentUser
                                          ?.updateEmail(emailController.text)
                                          .then((value) async {
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser?.uid)
                                            .set({
                                          'nom': nomController.text,
                                          'prenom': prenomController.text,
                                          'email': emailController.text,
                                          'faculte': faculteController.text,
                                          'option': optionController.text,
                                          //   'password': passwordController.text
                                        }).then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            showCloseIcon: true,
                                            content: Container(
                                                alignment: Alignment.center,
                                                child: const Row(children: [
                                                  Icon(
                                                      Icons
                                                          .check_circle_outline_rounded,
                                                      color: Colors.green),
                                                  Text(
                                                    '  Modification réussie',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                ])),
                                            backgroundColor: Colors.white,
                                          ));
                                          setState(() {});
                                        });
                                      });
                                    } else {
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .set({
                                        'nom': nomController.text,
                                        'prenom': prenomController.text,
                                        'email': emailController.text,
                                        'faculte': faculteController.text,
                                        'option': optionController.text,
                                        //   'password': passwordController.text
                                      }).then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          showCloseIcon: true,
                                          content: Container(
                                              alignment: Alignment.center,
                                              child: const Row(children: [
                                                Icon(
                                                    Icons
                                                        .check_circle_outline_rounded,
                                                    color: Colors.green),
                                                Text(
                                                  '  Modification réussie',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ])),
                                          backgroundColor: Colors.white,
                                        ));
                                        setState(() {});
                                      });
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: Text(e.code),
                                            content: SizedBox(
                                                child: Text(e.message!))));
                                  }
                                }
                              },
                              child: const Text("Modifier")),
                        ]))))
          ]));
        });
  }
}
