import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freeclassroom/test.dart';

double fieldsMargin = 20, fieldsWidth = 200;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool visiblePassword = false, visibleConfirmPassword = false;
  int complexity = -1;
  Color complexityColor = Colors.white;

  TextEditingController emailController = TextEditingController(),
      nomController = TextEditingController(),
      prenomController = TextEditingController(),
      faculteController = TextEditingController(),
      optionController = TextEditingController(),
      confirmpasswordController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    faculteController.dispose();
    optionController.dispose();
    confirmpasswordController.dispose();
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
    return MaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                primary: Colors.blue, seedColor: Colors.white)),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text(
                "Free classrooms",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
            body: Column(children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Expanded(
                  child: Center(
                      child: SizedBox(
                          height: 500,
                          width: 270,
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
                                height: 40,
                                //  decoration: BoxDecoration(
                                //      borderRadius: BorderRadius.circular(10),
                                //      border: Border.all()),
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
                              margin: EdgeInsets.only(bottom: fieldsMargin),
                              width: fieldsWidth,
                              child: Column(children: [
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
                                        complexity = evalComplexity(value);
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
                                            visiblePassword = !visiblePassword;
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
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(
                                                top: 10, right: 5),
                                            height: 5,
                                            color: complexityColor,
                                            width: fieldsWidth / 5),
                                      )),
                                if (complexity > -1)
                                  SizedBox(
                                      width: fieldsWidth,
                                      child: Text(
                                        complexity == 4
                                            ? 'Excellent'
                                            : complexity == 3
                                                ? 'Moyen'
                                                : 'Faible',
                                        textAlign: TextAlign.start,
                                      ))
                              ]),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: fieldsMargin),
                                width: fieldsWidth,
                                child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Entrer votre mot de passe à nouveau';
                                      }
                                      if (value != passwordController.text) {
                                        return "Mot de passe non identiques";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        label: const Text(
                                            "Confirmer Mot de passe"),
                                        suffixIcon: IconButton(
                                            icon: Icon(visibleConfirmPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            onPressed: () {
                                              setState(() {
                                                visibleConfirmPassword =
                                                    !visibleConfirmPassword;
                                              });
                                            })))),
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              const Text("J'ai lu et j'accepete"),
                              TextButton(
                                  onPressed: () {
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
                                                  margin: const EdgeInsets.only(
                                                      top: 30),
                                                  height: 600,
                                                  child: ListView(
                                                    children: [Text(terms)],
                                                  ))
                                            ],
                                          ));
                                        });
                                  },
                                  child: const Text('les condtitions')),
                              const Text("et la"),
                            ]),
                            Container(
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                                child: Column(children: [
                                              const Text(
                                                  "Politique de confidentialié",
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                  textAlign: TextAlign.center),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 30),
                                                  height: 600,
                                                  child: ListView(
                                                    children: [
                                                      Text(privacypolicy)
                                                    ],
                                                  ))
                                            ]));
                                          });
                                    },
                                    child: const Text(
                                        "politique de confidentialité"))),
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
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) async {
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(value.user?.uid)
                                            .set({
                                          'nom': nomController.text,
                                          'prenom': prenomController.text,
                                          'faculte': faculteController.text,
                                          'option': optionController.text,
                                          'password': passwordController.text
                                        }).then((value) {
                                          nomController.clear();
                                          prenomController.clear();
                                          faculteController.clear();
                                          optionController.clear();
                                          passwordController.clear();
                                          confirmpasswordController.clear();
                                        });
                                        await FirebaseAuth.instance
                                            .signInWithCredential(
                                                value.credential!)
                                            .then((value) async {
                                          //  var doc = FirebaseFirestore.instance
                                          //    .collection("email")
                                          //  .doc(emailController.text);
                                          //print(doc);
                                        });
                                      });
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
                                child: const Text(
                                  "S'inscrire",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ]))))
            ])));
  }
}
