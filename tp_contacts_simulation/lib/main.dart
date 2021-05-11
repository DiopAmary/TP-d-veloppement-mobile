import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tp_contacts_simulation/blocs/contactBloc.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageBloc.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageState.dart';
import 'package:tp_contacts_simulation/repositories/contactRepository.dart';
import 'package:tp_contacts_simulation/repositories/messageRepository.dart';
import 'package:tp_contacts_simulation/ui/pages/contacts/contactPage.dart';
import 'package:tp_contacts_simulation/ui/pages/messages/messagesPage.dart';

import 'blocs/contactState.dart';
import 'enums/enums.dart';

void main() {
  GetIt.instance.registerLazySingleton(() => new ContactRepository());
  GetIt.instance.registerLazySingleton(() => new MessageRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactBloc(
              ContactState(
                  conatacts: [],
                  requesteState: RequesteState.NONE,
                  errorMessage: ''),
              GetIt.instance<ContactRepository>()),
        ),
        BlocProvider(
            create: (context) => MessageBloc(MessageState.initialState(),
                GetIt.instance<MessageRepository>()))
      ],
      child: MaterialApp(
        title: 'Contact simulation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          '/contacts': (context) => ContactPage(),
          '/messages': (context) => MessagesPage(),
        },
        initialRoute: '/contacts',
      ),
    );
  }
}
