import 'package:flutter/material.dart';
import 'package:freeclassroom/custompage.dart';
import 'test.dart';
import 'note.dart';
import 'database.dart';

class EditNote extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditNote(this.data, {super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController noteController = TextEditingController(),
      nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    noteController.text = widget.data['note'];
    nameController.text = widget.data['nom'];
    return CustomPage(Column(children: [
      const PageTitle(""),
      TextFormField(
        controller: noteController,
        style: const TextStyle(),
        // cursorColor: ,
        decoration: const InputDecoration(counterStyle: TextStyle()),
        maxLines: 5,
        maxLength: 500,
        validator: (t) {
          if (t != null && t.isEmpty) {
            return "Rentrer quelque chose ";
          }
          return null;
        },
      ),
      Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white)),
          child: TextButton(
            child: const Text(
              'Modifier',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            onPressed: () {
              if (noteController.text.isNotEmpty) {
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
                                  style: TextStyle(fontSize: 20),
                                ),
                                TextFormField(
                                  controller: nameController,
                                  maxLines: 1,
                                  maxLength: 50,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (t) {
                                    if (t != null && t.isEmpty) {
                                      return "Rentrer le nom de la note ";
                                    }
                                    return null;
                                  },
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (nameController.text.isNotEmpty) {
                                        await DatabaseHelper.updateNote({
                                          'id': widget.data['id'],
                                          'nom': nameController.text,
                                          'note': noteController.text,
                                          'modif': DateTime.now().toString()
                                        }).then((value) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Note()));
                                        });

                                        // noteController.clear();
                                        // nameController.clear();
                                      }
                                    },
                                    child: const Text("Enregistrer"))
                              ],
                            )),
                      );
                    });
                //noteController.clear();
              }
            },
          ))
    ]));
  }
}
