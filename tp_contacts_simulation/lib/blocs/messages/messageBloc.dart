import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageActions.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageState.dart';
import 'package:tp_contacts_simulation/enums/enums.dart';
import 'package:tp_contacts_simulation/models/messageModel.dart';
import 'package:tp_contacts_simulation/repositories/messageRepository.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository messageRepository;
  MessageBloc(@required MessageState initialState, this.messageRepository)
      : super(initialState);

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is MessageByContactEvent) {
      yield MessageState(
          requesteState: RequesteState.LOADING,
          messages: state.messages,
          currentEvent: event);
      try {
        List<Message> data =
            await messageRepository.messageByContact(event.payLoad.id);
        yield MessageState(
            requesteState: RequesteState.LOADED,
            messages: data,
            currentEvent: event);
      } catch (e) {
        yield MessageState(
            requesteState: RequesteState.ERROR,
            messages: state.messages,
            currentEvent: event,
            messageError: e.message);
      }
    } else if (event is AddNewMessageEvent) {
      try {
        event.payLoad.date = DateTime.now();
        Message message = await messageRepository.addNewMessage(event.payLoad);
        List<Message> data = [...state.messages];
        data.add(message);
        yield MessageState(
            requesteState: RequesteState.LOADED,
            messages: data,
            currentEvent: event);
      } catch (e) {
        yield MessageState(
            requesteState: RequesteState.ERROR,
            messages: state.messages,
            currentEvent: event,
            messageError: e.message);
      }
    }
  }
}
