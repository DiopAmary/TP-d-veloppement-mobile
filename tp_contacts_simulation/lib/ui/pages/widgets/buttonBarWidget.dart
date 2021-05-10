import 'package:flutter/material.dart';
import 'package:tp_contacts_simulation/blocs/contactActions.dart';
import 'package:tp_contacts_simulation/ui/pages/widgets/buttonWidget.dart';

class ButtonBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonWidget(
              buttonLabel: 'All contacts',
              contactEvent: new LoadAllContactEvent()),
          ButtonWidget(
              buttonLabel: 'Etudiants', contactEvent: new LoadStudentEvent()),
          ButtonWidget(
              buttonLabel: 'Developpeurs',
              contactEvent: new LoadDeveloperEvent())
        ],
      ),
    );
  }
}
