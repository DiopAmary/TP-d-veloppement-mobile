import 'package:tp_contacts_simulation/models/contactModel.dart';
import 'package:tp_contacts_simulation/models/messageModel.dart';

abstract class MessageEvent<T> {
  T payLoad;
  MessageEvent({this.payLoad});
}

class MessageByContactEvent extends MessageEvent<Contact> {
  MessageByContactEvent(Contact payLoad) : super(payLoad: payLoad);
}

class AddNewMessageEvent extends MessageEvent<Message> {
  AddNewMessageEvent(Message payLoad) : super(payLoad: payLoad);
}
