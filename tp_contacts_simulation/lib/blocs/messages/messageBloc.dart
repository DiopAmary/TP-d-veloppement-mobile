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
          currentEvent: event,
          selectedMessages: state.selectedMessages);
      try {
        List<Message> data =
            await messageRepository.messageByContact(event.payLoad.id);
        yield MessageState(
            requesteState: RequesteState.LOADED,
            messages: data,
            currentEvent: event,
            selectedMessages: state.selectedMessages);
      } catch (e) {
        yield MessageState(
            requesteState: RequesteState.ERROR,
            messages: state.messages,
            currentEvent: event,
            messageError: e.message,
            selectedMessages: state.selectedMessages);
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
            currentEvent: event,
            selectedMessages: state.selectedMessages);
      } catch (e) {
        yield MessageState(
            requesteState: RequesteState.ERROR,
            messages: state.messages,
            currentEvent: event,
            messageError: e.message,
            selectedMessages: state.selectedMessages);
      }
    } else if (event is SelectMessageEvent) {
      List<Message> messages = state.messages;
      List<Message> selectedMessages = [...state.selectedMessages];
      for (Message m in messages) {
        if (m.id == event.payLoad.id) {
          m.seleted = !m.seleted;
        }
        if (m.seleted == true) {
          selectedMessages.add(m);
        } else {
          selectedMessages.removeWhere((element) => element.id == m.id);
        }
      }
      MessageState messageState = MessageState(
          messages: messages,
          selectedMessages: selectedMessages,
          currentEvent: event,
          requesteState: RequesteState.LOADED);
      yield messageState;
    } else if (event is DeleteMessageEvent) {
      List<Message> messages = state.messages;
      List<Message> selectedMessages = [...state.selectedMessages];
      for (Message m in selectedMessages) {
        await messageRepository.deleteMessage(m);
        messages.removeWhere((element) => element.id == m.id);
      }
      MessageState messageState = MessageState(
          messages: messages,
          selectedMessages: selectedMessages,
          currentEvent: event,
          requesteState: RequesteState.LOADED);
      yield messageState;
    }
  }
}
