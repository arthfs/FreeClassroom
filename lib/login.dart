import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visiblePassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
         
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                primary: Colors.blue, seedColor: Colors.white)),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Free classrooms",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
            body: Column(children: [
              const Text(
                "Login",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onEditingComplete: () {},
                validator: (tempemail) {
                  if (tempemail!.isEmpty) return "Entrer un email";

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
                    fillColor: Colors.red,
                    labelStyle: TextStyle(color: Colors.red)),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: visiblePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onEditingComplete: () {},
                validator: (temppass) {
                  if (temppass!.isEmpty) return "Entrer votre mot de passe";

                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(visiblePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            visiblePassword = !visiblePassword;
                          });
                        }),
                    label: const Text("Mot de passe"),
                    fillColor: Colors.red,
                    labelStyle: const TextStyle(color: Colors.red)),
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Mot de passe oubliée',
                                textAlign: TextAlign.center),
                            content: SizedBox(
                                height: 300,
                                child: Column(
                                  children: [
                                    TextButton(
                                        onPressed: () async {
                                          try {
                                            await FirebaseAuth.instance
                                                .sendPasswordResetEmail(
                                                    email: emailController.text)
                                                .then((value) {
                                              Navigator.of(context).pop();
                                            });
                                          } on FirebaseAuthException catch (e) {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                        title: Text(e.code),
                                                        content: SizedBox(
                                                            child: Text(
                                                                e.message!))));
                                          }
                                        },
                                        child: const Text(
                                            "Envoyer moi un lien sur mon email pour réinitialiser mon mot de passe"))
                                  ],
                                )),
                          );
                        });
                  },
                  child: const Text(
                    'Mot de passe oubliée',
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
                                  style: TextStyle(color: Colors.white),
                                ));
                          });
                    } else {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                      } on FirebaseAuthException catch (e) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: Text(e.code),
                                content: SizedBox(child: Text(e.message!))));
                      }

                      /*      FirebaseAuth.instance.signInAnonymously().then((value) {
                        //  var doc = FirebaseFirestore.instance
                        //    .collection("email")
                        //    .doc(emailController.text);
                        //print(doc);

                        // if (doc == null) {
                        FirebaseFirestore.instance
                            .collection('email')
                            .doc(emailController.text)
                            .set({'uid': value.user?.uid});
                        //  }
                      });*/
                      //  setState(() {});
                    }
                  },
                  child: const Text(
                    "Connecter",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const SignUp())));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(color: Colors.white),
                  ))
            ])));
  }
}
