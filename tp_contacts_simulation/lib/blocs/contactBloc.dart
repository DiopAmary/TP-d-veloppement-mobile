import 'package:bloc/bloc.dart';
import 'package:tp_contacts_simulation/models/contactModel.dart';
import 'package:tp_contacts_simulation/repositories/contactRepository.dart';

abstract class ContactEvent{}
class LoadAllContactEvent extends ContactEvent{}
class LoadStudentEvent extends ContactEvent{}
class LoadDeveloperEvent extends ContactEvent{}

enum RequesteState {LOADING, LOADED, ERROR, NONE}

class ContactState{
  List<Contact> conatacts;
  RequesteState requesteState;
  String errorMessage;
  ContactState({this.conatacts, this.requesteState, this.errorMessage});
}

class ContactBloc extends Bloc<ContactEvent, ContactState>{
  ContactRepository contactRepository;
  ContactBloc(ContactState initialState, this.contactRepository) : super(initialState);

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if(event is LoadAllContactEvent){

    }else if(event is LoadStudentEvent){

    }else if(event is LoadDeveloperEvent){
      yield ContactState(conatacts: state.conatacts, requesteState: RequesteState.LOADING);
      try{
        List<Contact> data = await contactRepository.allContacts();
        yield ContactState(conatacts: data, requesteState: RequesteState.LOADED);
      }catch(e){
        yield ContactState(conatacts: state.conatacts, requesteState: RequesteState.ERROR, errorMessage: e.message);
      }

    }
  }

}