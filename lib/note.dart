import 'package:flutter/material.dart';
import 'package:freeclassroom/editnote.dart';
import 'package:freeclassroom/test.dart';
import 'custompage.dart';
import 'database.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  TextEditingController noteController = TextEditingController(),
      nameController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseHelper.read(),
        builder: (context, snapshot) {
          List notes = snapshot.data ?? [];
          return CustomPage(Column(children: [
            const PageTitle('Notes'),
            Container(
                margin: const EdgeInsets.only(top: 50),
                height: 550,
                //color: Colors.amber,
                child: ListView(
                  children: notes
                      .map((e) => Container(
                          margin: const EdgeInsets.only(bottom: 550 / 4),
                          child: Column(children: [
                            GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => EditNote(e))),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(),
                                      color: Colors.grey.shade300,
                                    ),
                                    width: 400,
                                    height: 60,
                                    child: Text(e['nom']))),
                            Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () async {
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
                                                ' Note supprimée avec succès',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )
                                            ])),
                                        backgroundColor: Colors.white,
                                      ));
                                      DatabaseHelper.delete(e['id']);
                                      await playsound('delete.mp3')
                                          .then((value) => {setState(() {})});
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )))
                          ])))
                      .toList(),
                )),
            Container(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: const Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: SizedBox(
                                    height: 400,
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Nouvelle note",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        TextFormField(
                                          controller: noteController,
                                          maxLines: 5,
                                          maxLength: 500,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (t) {
                                            if (t != null && t.isEmpty) {
                                              return "Rentrer quelque chose ";
                                            }
                                            return null;
                                          },
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              if (noteController
                                                  .text.isNotEmpty) {
                                                Navigator.of(context).pop();
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: SizedBox(
                                                            height: 400,
                                                            child: Column(
                                                              children: [
                                                                const Text(
                                                                  "Nom de la note",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      nameController,
                                                                  maxLines: 1,
                                                                  maxLength: 50,
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  validator:
                                                                      (t) {
                                                                    if (t !=
                                                                            null &&
                                                                        t.isEmpty) {
                                                                      return "Rentrer le nom de la note ";
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      if (nameController
                                                                          .text
                                                                          .isNotEmpty) {
                                                                        DatabaseHelper
                                                                            .insertNote({
                                                                          'nom':
                                                                              nameController.text,
                                                                          'note':
                                                                              noteController.text,
                                                                          'modif':
                                                                              DateTime.now().toString()
                                                                        }).then(
                                                                            (value) async {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            behavior:
                                                                                SnackBarBehavior.floating,
                                                                            showCloseIcon:
                                                                                true,
                                                                            content: Container(
                                                                                alignment: Alignment.center,
                                                                                child: const Row(children: [
                                                                                  Icon(Icons.check_circle_outline_rounded, color: Colors.green),
                                                                                  Text(
                                                                                    ' Note ajoutée avec succès',
                                                                                    style: TextStyle(color: Colors.black),
                                                                                  )
                                                                                ])),
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                          ));
                                                                          await playsound('added.wav')
                                                                              .then((value) {
                                                                            setState(() {});
                                                                          });
                                                                        });
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        noteController
                                                                            .clear();
                                                                        nameController
                                                                            .clear();
                                                                      }
                                                                    },
                                                                    child: const Text(
                                                                        "Enregistrer"))
                                                              ],
                                                            )),
                                                      );
                                                    });
                                                noteController.clear();
                                              }
                                            },
                                            child: const Text("Ajouter"))
                                      ],
                                    )));
                          });
                    }))
          ]));
        });
  }
}
