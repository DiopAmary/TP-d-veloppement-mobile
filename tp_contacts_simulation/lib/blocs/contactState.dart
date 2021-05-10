import 'package:tp_contacts_simulation/enums/enums.dart';
import 'package:tp_contacts_simulation/models/contactModel.dart';

import 'contactActions.dart';

class ContactState {
  List<Contact> conatacts;
  RequesteState requesteState;
  String errorMessage;
  ContactEvent currentEvent;
  ContactState(
      {this.conatacts,
      this.requesteState,
      this.errorMessage,
      this.currentEvent});
}
