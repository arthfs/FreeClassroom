import 'package:flutter/material.dart';
import 'test.dart';
import 'custompage.dart';

class PageTd extends StatefulWidget {
  final data;
  const PageTd(this.data, {super.key});

  @override
  State<PageTd> createState() => _PageTdState();
}

class _PageTdState extends State<PageTd> {
  @override
  Widget build(BuildContext context) {
    List tds = widget.data['td'];
    print(tds);
    return CustomPage(Column(children: [
      Container(
        alignment: Alignment.center,
        child: PageTitle(
            "Horaire td ${widget.data['jour'].toString().substring(0, 1).toUpperCase()}${widget.data['jour'].toString().substring(1)}"),
      ),
      Container(
          margin: const EdgeInsets.only(top: 50),
          height: 500,
          child: ListView(
              children: tds
                  .map((t) => Container(
                      margin: const EdgeInsets.only(bottom: 500 / 4),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.arrow_circle_right_outlined,
                                color: Colors.red),
                            Text('${t['heure']}'),
                            Text('${t['salle']}'),
                            Text('${t['prof']}')
                          ])))
                  .toList()))
    ]));
  }
}
