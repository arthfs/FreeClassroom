import 'package:flutter/material.dart';
import 'custompage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'horaire.dart';
import 'test.dart';

String heure = '', mins = '';
var jour = "Lundi";
List excluded = [];
List<DropdownMenuItem> heures =
    ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ))
        .toList();
List displayed = [...horaires];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double listViewHeight = 500, fontSize = 25;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    return CustomPage(
      key: context.widget.key,
      Stack(children: [
        Image.asset(
          "assets/background.png",
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            /*   TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(notif);
                  await playsound('delete.mp3');
                  //  setState(() {
                  // FirebaseAuth.instance.signOut();
                  //});
                },
                child: const Text("Logout")),*/
            const Text(
              "Vérifier les salles quis sont libres en ce moment",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 40),
            Row(children: [
              DropdownButton(
                  iconEnabledColor: Colors.white,
                  //focusColor: Colors.red,
                  // style: const TextStyle(),
                  dropdownColor: Colors.red,
                  hint: const Text("Jour",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  value: jour,
                  items: heures,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        jour = value.toString();
                        if (heure.isNotEmpty && mins.isNotEmpty) search();
                      });
                    }
                  }),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    IconButton(
                        onPressed: () async {
                          await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                heure = value.hour.toString();
                                mins = value.minute.toString().padLeft(2, '0');
                                search();
                              });
                            }
                          });
                        },
                        icon:
                            const Icon(Icons.access_time, color: Colors.white)),
                    Text(
                      '$heure h: $mins',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ]))
            ]),
            SizedBox(
                // color: Colors.amber,
                height: listViewHeight,
                child: ListView(
                    children: heure.isEmpty
                        ? []
                        : displayed
                            .map((e) => Container(
                                margin:
                                    EdgeInsets.only(bottom: listViewHeight / 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Text(e['jour']!),
                                    //Text(e['heure']!),
                                    Text(e['salle']!,
                                        style: TextStyle(
                                            color: Colors.white,
                                            backgroundColor: Colors.red,
                                            fontSize: fontSize)),
                                    const Text("prochain cours dans",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),

                                    Text(
                                      e['dispo'] != null ? "${e['dispo']}" : "",
                                      style: TextStyle(
                                          backgroundColor: Colors.red,
                                          color: Colors.white,
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    )
                                  ],
                                )))
                            .toList())),
          ],
        )
      ]),
    );
  }
}

class Heure {
  int heure, minute;
  Heure(this.heure, this.minute);
  @override
  toString() {
    return ('$heure : $minute');
  }
}

bool overlap(Heure debut, Heure fin, Heure c) {
  if (c.heure > fin.heure) {
    return false;
  } else {
    if (c.heure == fin.heure && c.minute > fin.minute) {
      return false;
    } else {
      if (c.heure < debut.heure) {
        return false;
      } else if (c.heure == debut.heure && c.minute < debut.minute) {
        return false;
      }
    }
  }
  return true;
}

void search() {
  List<String> classes = [];
  excluded = [];
  for (var h in horaires) {
    //print(h);
    try {
      // print(h);
      if (!classes.contains(h['salle'])) {
        classes.add(h['salle']!);
      }
    } catch (e) {
      //print(h);
    }
  }
  //print(classes.length);
  // print("$jour $heure h: $mins");
  List<Map<String, String>> s = [];
  for (var element in horaires) {
    //print(element);
    Heure h = Heure(int.parse(heure), int.parse(mins));
    int n = element['heure']!.length;
    bool notoverlapping = true;
    try {
      // print(jour);
      Heure debut = Heure(
          int.parse(element['heure']!.substring(0, 5).split(":")[0]),
          int.parse(element['heure']!.substring(0, 5).split(':')[1]));
      Heure fin = Heure(
          int.parse(element['heure']!.substring(n - 8, n - 3).split(":")[0]),
          int.parse(element['heure']!.substring(n - 8, n - 3).split(':')[1]));
      notoverlapping = overlap(debut, fin, h) == false;

      // print(
      //   "${element['heure']!.substring(0, 5)} ${element['heure']!.substring(n - 8, n - 3)}");
    } catch (e) {
      //print(element);
    }
    //Heure o = Heure(element['heure'], minute)
    bool verdict = element['jour']!.compareTo(jour) == 0 && notoverlapping;
    //print(verdict);
    if (verdict == false && element['jour']!.compareTo(jour) == 0) {
      //print(element['salle']);
      excluded.add(element);
    }
    // if (element['salle'] == 'B107') {
    //   for (var e in excluded) {
    // print(e);
    //   }
    //}
    if (verdict || (element['jour']!.compareTo(jour) != 0)) {
      // print('yes');
      if (s.isEmpty) {
        s.add(element);
      } else {
        bool present = false;
        for (var ss in s) {
          if (ss['salle']!.compareTo(element['salle']!) == 0) {
            present = true;
            break;
          }
        }
        if (!present) {
          // print(element);
          // element['heure'] = '2';
          s.add(element);
        }
      }
    }
  }

  // print(s);
  List dispo = (classes
          .toSet()
          .difference(excluded.map((e) => e['salle']).toList().toSet()))
      .toList();
  // print(dispo);
  for (var d in dispo) {
    bool present = false;
    for (var c in s) {
      if (c['salle']!.compareTo(d) == 0) {
        present = true;
        break;
      }
    }
    if (!present) {
      //  print(d);
      s.add({'salle': d});
    }
  }

  //print(s);

  List<Map<String, String>> resultat = [];
  for (var r in s) {
    if (dispo.contains(r['salle'])

        //&&
        //r['salle']!.compareTo("C203") == 0
        ) {
      Heure fincours = Heure(
          int.parse(heure
              //  r['heure']!.substring(n - 8, n - 3).split(":")[0]
              ),
          int.parse(mins
              // r['heure']!.substring(n - 8, n - 3).split(':')[1]
              ));
      //  print(fincours.toString());

      try {
        String result = nexthour(r['jour']!, fincours.toString(), r['salle']!);
        //  print("@${result.split('.')[0].split(':')[0]}");
        Map<String, String> ss = <String, String>{};
        ss['dispo'] = result.split('.')[0].split(':')[0] == '0'
            ? "${result.split('.')[0].split(':')[1]} m"
            : '${result.split('.')[0].split(':').getRange(0, 2).join('h:')}m';
        ss['salle'] = r['salle']!;
        //  print(ss);
        resultat.add(ss);
      } catch (e) {
        //  print("error $r");
        //  print(fincours.toString());
        //print(  "isempty ${nexthour(r['jour']!, fincours.toString(), r['salle']!).isEmpty}");
        break;
      }
      // print(resultat);

      // resultat.add(ss);
    }
  }
  //print(resultat.length);
  displayed = resultat;
  print(displayed.length);
}
