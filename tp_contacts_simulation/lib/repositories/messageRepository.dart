import 'dart:math';

import 'package:tp_contacts_simulation/models/messageModel.dart';

class MessageRepository {
  int messageCount;
  MessageRepository() {
    this.messageCount = messages.length;
  }
  Map<int, Message> messages = {
    1: Message(
        id: 1,
        contactID: 1,
        date: DateTime.now(),
        content: "Salut le frère",
        type: 'envoyer',
        seleted: false),
    2: Message(
        id: 2,
        contactID: 1,
        date: DateTime.now(),
        content: "Comment tu vas ?",
        type: 'envoyer',
        seleted: false),
    3: Message(
        id: 3,
        contactID: 1,
        date: DateTime.now(),
        content:
            "Salutaion mousaillon. Comment va la famille et les muguiwara ? Tout le monde se porte bien",
        type: 'recu',
        seleted: false),
    4: Message(
        id: 4,
        contactID: 2,
        date: DateTime.now(),
        content: "yoo bro comment tu vas ?",
        type: 'envoyer',
        seleted: false),
    5: Message(
        id: 5,
        contactID: 2,
        date: DateTime.now(),
        content: "Je me porte super bien !!!",
        type: 'recu',
        seleted: false),
    6: Message(
        id: 6,
        contactID: 2,
        date: DateTime.now(),
        content: "Cool alors !!!",
        type: 'recu',
        seleted: false)
  };

  Future<List<Message>> allMessages() async {
    var future = await Future.delayed(Duration(seconds: 1));
    int random = new Random().nextInt(10);
    if (random > 2) {
      return messages.values.toList();
    } else {
      throw Exception("Internet ERROR");
    }
  }

  Future<List<Message>> messageByContact(int contactID) async {
    var future = await Future.delayed(Duration(seconds: 1));
    int random = new Random().nextInt(10);
    if (random > 2) {
      return messages.values
          .toList()
          .where((element) => element.contactID == contactID)
          .toList();
    } else {
      throw Exception("Internet ERROR");
    }
  }

  Future<Message> addNewMessage(Message message) async {
    var future = await Future.delayed(Duration(seconds: 1));
    int random = new Random().nextInt(10);
    if (random > 0) {
      message.id = ++messageCount;
      messages[message.id] = message;
      return message;
    } else {
      throw Exception("Internet ERROR");
    }
  }

  Future<void> deleteMessage(Message message) async {
    var future = await Future.delayed(Duration(seconds: 1));
    int random = new Random().nextInt(10);
    if (random > 1) {
      messages.remove(message.id);
    } else {
      throw Exception("Internet ERROR");
    }
  }
}
