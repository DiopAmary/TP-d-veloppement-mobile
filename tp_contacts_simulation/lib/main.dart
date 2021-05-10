import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_contacts_simulation/blocs/contactBloc.dart';
import 'package:tp_contacts_simulation/repositories/contactRepository.dart';
import 'package:tp_contacts_simulation/ui/pages/contacts/contactPage.dart';

import 'blocs/contactState.dart';
import 'enums/enums.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
              new ContactRepository()),
        )
      ],
      child: MaterialApp(
        title: 'Contact simulation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          '/contacts': (context) => ContactPage(),
        },
        initialRoute: '/contacts',
      ),
    );
  }
}
