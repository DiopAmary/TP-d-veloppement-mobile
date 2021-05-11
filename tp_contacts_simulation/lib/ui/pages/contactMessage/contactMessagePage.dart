import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_contacts_simulation/blocs/contactActions.dart';
import 'package:tp_contacts_simulation/blocs/contactBloc.dart';
import 'package:tp_contacts_simulation/blocs/contactState.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageActions.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageBloc.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageState.dart';
import 'package:tp_contacts_simulation/enums/enums.dart';
import 'package:tp_contacts_simulation/models/messageModel.dart';
import 'package:tp_contacts_simulation/ui/pages/widgets/retryWidget.dart';

class ContactMessagePage extends StatelessWidget {
  get contact => null;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = new ScrollController();
    TextEditingController textEditingController = new TextEditingController();
    context.read<ContactBloc>().add(new LoadAllContactEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts et Messages"),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) => Column(
                children: [
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          width: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                child:
                                    Text("${state.conatacts[index].profile}"),
                              ),
                              Text("${state.conatacts[index].name}"),
                              Text("${state.conatacts[index].score}"),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(50, 229, 194, 192),
                              border: Border.all(
                                  width: 1, color: Colors.deepPurple)),
                        ),
                      ),
                      itemCount: state.conatacts.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Expanded(child: BlocBuilder<MessageBloc, MessageState>(
                      builder: (context, state) {
                    if (state.requesteState == RequesteState.LOADING) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.requesteState == RequesteState.ERROR) {
                      return RetryWidget(
                        errorMessage: state.messageError,
                        onAction: () {
                          context.read<MessageBloc>().add(state.currentEvent);
                        },
                      );
                    } else if (state.requesteState == RequesteState.LOADED) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        var scrollController;
                        if (scrollController.hasClients)
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                      });
                      return ListView.separated(
                          controller: scrollController,
                          itemBuilder: (context, index) => ListTile(
                                selected: state.messages[index].seleted,
                                selectedTileColor:
                                    Color.fromARGB(50, 160, 185, 198),
                                onLongPress: () {
                                  context.read<MessageBloc>().add(
                                      new SelectMessageEvent(
                                          state.messages[index]));
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      (state.messages[index].type == "envoyer")
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                  children: [
                                    (state.messages[index].type == "recu")
                                        ? SizedBox(
                                            width: 100,
                                          )
                                        : SizedBox(
                                            width: 0,
                                          ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: (state.messages[index].type ==
                                                "envoyer")
                                            ? Color.fromARGB(20, 0, 255, 0)
                                            : Color.fromARGB(50, 229, 194, 192),
                                        child: Text(
                                            "${state.messages[index].content}"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          separatorBuilder: (context, index) => Divider(
                                height: 1,
                                color: Colors.white,
                              ),
                          itemCount: state.messages.length);
                    } else {
                      return Container();
                    }
                  })),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: textEditingController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "Votre message",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        )),
                        IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              Message message = new Message(
                                  type: "envoyer",
                                  contactID: this.contact.id,
                                  content: textEditingController.text,
                                  seleted: false);
                              context
                                  .read<MessageBloc>()
                                  .add(new AddNewMessageEvent(message));

                              Message response = new Message(
                                  type: "recu",
                                  contactID: this.contact.id,
                                  content: "Response au message suivant : \n" +
                                      textEditingController.text,
                                  seleted: false);
                              context
                                  .read<MessageBloc>()
                                  .add(new AddNewMessageEvent(response));
                              textEditingController.text = "";
                            })
                      ],
                    ),
                  ),
                ],
              )),
    );
  }
}
