import 'dart:math';
import 'package:tp_contacts_simulation/models/contactModel.dart';

class ContactRepository {
  Map<int, Contact> contacts = {
    1: Contact(
        id: 1, name: 'Alpha', profile: 'AL', type: 'Etudiant', score: 23),
    2: Contact(
        id: 2, name: 'Samba', profile: 'SA', type: 'Developpeur', score: 12),
    3: Contact(
        id: 3, name: 'Modou', profile: 'MO', type: 'Etudiant', score: 31),
    4: Contact(
        id: 4, name: 'Issa', profile: 'IS', type: 'Developpeur', score: 27),
    5: Contact(
        id: 5, name: 'Ouseynou', profile: 'OU', type: 'Developpeur', score: 98),
    6: Contact(
        id: 6, name: 'Peinda', profile: 'PE', type: 'Etudiant', score: 72),
    7: Contact(
        id: 7, name: 'Amina', profile: 'AM', type: 'Etudiant', score: 10),
  };

  Future<List<Contact>> allContacts() async {
    var future = await Future.delayed(Duration(seconds: 1));
    int random = new Random().nextInt(10);
    if (random > 3) {
      return contacts.values.toList();
    } else {
      throw Exception("Internet ERROR");
    }
  }

  Future<List<Contact>> contactsByType(String type) async {
    var future = await Future.delayed(Duration(seconds: 1));
    int random = new Random().nextInt(10);
    if (random > 3) {
      return contacts.values.toList().where((element) => element.type == type);
    } else {
      throw Exception("Internet ERROR");
    }
  }
}
