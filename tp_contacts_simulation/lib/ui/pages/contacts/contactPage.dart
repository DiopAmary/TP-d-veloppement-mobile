import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_contacts_simulation/blocs/contactBloc.dart';
import 'package:tp_contacts_simulation/blocs/contactState.dart';
import 'package:tp_contacts_simulation/enums/enums.dart';
import 'package:tp_contacts_simulation/ui/pages/widgets/buttonBarWidget.dart';
import 'package:tp_contacts_simulation/ui/pages/widgets/contactListWidget.dart';
import 'package:tp_contacts_simulation/ui/pages/widgets/retryWidget.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacs'),
        ),
        body: Column(
          children: [
            ButtonBarWidget(),
            Expanded(child: BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {
              if (state.requesteState == RequesteState.LOADING) {
                return Center(child: CircularProgressIndicator());
              } else if (state.requesteState == RequesteState.ERROR) {
                return RetryWidget(
                  errorMessage: state.errorMessage,
                  onAction: () {
                    context.read<ContactBloc>().add(state.currentEvent);
                  },
                );
              } else if (state.requesteState == RequesteState.LOADED) {
                return ContactListWidget(contacts: state.conatacts);
              } else {
                return Container();
              }
            }))
          ],
        ));
  }
}
