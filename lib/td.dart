import 'package:flutter/material.dart';
import 'test.dart';
import 'pagetd.dart';
import 'custompage.dart';

var object = [
  {
    'jour': 'lundi',
    "td": [
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      }
    ]
  },
  {
    'jour': 'mardi',
    "td": [
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      }
    ]
  },
  {
    'jour': 'mercredi',
    "td": [
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      }
    ]
  },
  {
    'jour': 'jeudi',
    "td": [
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      }
    ]
  },
  {
    'jour': 'vendredi',
    "td": [
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      }
    ]
  },
  {
    'jour': 'samedi',
    "td": [
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      }
    ]
  },
  {
    'jour': 'dimanche',
    "td": [
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      },
      {
        'heure': '10:00-12:00',
        'salle': 'F207',
        'code': 'MAT120',
        'prof': 'Paul Harold'
      }
    ]
  }
];

class Td extends StatefulWidget {
  const Td({super.key});

  @override
  State<Td> createState() => _TdState();
}

class _TdState extends State<Td> {
  @override
  Widget build(BuildContext context) {
    return CustomPage(Column(children: [
      Container(
        alignment: Alignment.center,
        child: const PageTitle("Horaire td"),
      ),
      Expanded(
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: object
                      .map((e) => Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: 115,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PageTd(e)));
                              },
                              child: Text(
                                "${e['jour'].toString().substring(0, 1).toUpperCase()}${e['jour'].toString().substring(1)}",
                                style: const TextStyle(color: Colors.white),
                              ))))
                      .toList())))
    ]));
  }
}
