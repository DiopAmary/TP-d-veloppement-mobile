import 'package:bloc/bloc.dart';
import 'package:tp_contacts_simulation/enums/enums.dart';
import 'package:tp_contacts_simulation/models/contactModel.dart';
import 'package:tp_contacts_simulation/repositories/contactRepository.dart';

import 'contactActions.dart';
import 'contactState.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactRepository contactRepository;
  ContactBloc(ContactState initialState, this.contactRepository)
      : super(initialState);

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is LoadAllContactEvent) {
      yield ContactState(
          conatacts: state.conatacts,
          requesteState: RequesteState.LOADING,
          currentEvent: event);
      try {
        List<Contact> data = await contactRepository.allContacts();
        yield ContactState(
            conatacts: data,
            requesteState: RequesteState.LOADED,
            currentEvent: event);
      } catch (e) {
        yield ContactState(
            conatacts: state.conatacts,
            requesteState: RequesteState.ERROR,
            errorMessage: e.message,
            currentEvent: event);
      }
    } else if (event is LoadStudentEvent) {
      yield ContactState(
          conatacts: state.conatacts,
          requesteState: RequesteState.LOADING,
          currentEvent: event);
      try {
        List<Contact> data = await contactRepository.contactsByType("Etudiant");
        yield ContactState(
            conatacts: data,
            requesteState: RequesteState.LOADED,
            currentEvent: event);
      } catch (e) {
        yield ContactState(
            conatacts: state.conatacts,
            requesteState: RequesteState.ERROR,
            errorMessage: e.message,
            currentEvent: event);
      }
    } else if (event is LoadDeveloperEvent) {
      yield ContactState(
          conatacts: state.conatacts,
          requesteState: RequesteState.LOADING,
          currentEvent: event);
      try {
        List<Contact> data =
            await contactRepository.contactsByType("Developpeur");
        yield ContactState(
            conatacts: data,
            requesteState: RequesteState.LOADED,
            currentEvent: event);
      } catch (e) {
        yield ContactState(
            conatacts: state.conatacts,
            requesteState: RequesteState.ERROR,
            errorMessage: e.message,
            currentEvent: event);
      }
    }
  }
}
