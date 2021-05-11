import 'package:tp_contacts_simulation/blocs/messages/messageActions.dart';
import 'package:tp_contacts_simulation/enums/enums.dart';
import 'package:tp_contacts_simulation/models/messageModel.dart';

class MessageState {
  RequesteState requesteState;
  List<Message> messages;
  String messageError;
  MessageEvent currentEvent;
  List<Message> selectedMessages = [];

  MessageState(
      {this.requesteState,
      this.currentEvent,
      this.messageError,
      this.messages,
      this.selectedMessages});

  MessageState.initialState()
      : requesteState = RequesteState.NONE,
        messages = [],
        messageError = '',
        currentEvent = null,
        selectedMessages = [];
}
