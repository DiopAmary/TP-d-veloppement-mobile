import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageActions.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageBloc.dart';
import 'package:tp_contacts_simulation/blocs/messages/messageState.dart';
import 'package:tp_contacts_simulation/enums/enums.dart';
import 'package:tp_contacts_simulation/models/contactModel.dart';
import 'package:tp_contacts_simulation/models/messageModel.dart';
import 'package:tp_contacts_simulation/ui/pages/widgets/retryWidget.dart';

class MessagesPage extends StatelessWidget {
  Contact contact;
  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = new TextEditingController();
    this.contact = ModalRoute.of(context).settings.arguments;
    context.read<MessageBloc>().add(MessageByContactEvent(this.contact));
    return Scaffold(
      appBar: AppBar(
        title: Text("${contact.name}"),
        actions: [
          BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
            return CircleAvatar(
              child: Text("${state.messages.length}"),
            );
          }),
          BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
            if (state.selectedMessages.length > 0) {
              return IconButton(
                  icon: Icon(Icons.restore_from_trash),
                  onPressed: () {
                    context.read<MessageBloc>().add(new DeleteMessageEvent());
                  });
            } else {
              return Container();
            }
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                CircleAvatar(
                  child: Text("${contact.profile}"),
                  radius: 30,
                ),
                SizedBox(
                  width: 25,
                ),
                Text('${contact.name}')
              ],
            ),
          ),
          Expanded(child:
              BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
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
                if (scrollController.hasClients)
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
              });
              return ListView.separated(
                  controller: scrollController,
                  itemBuilder: (context, index) => ListTile(
                        selected: state.messages[index].seleted,
                        selectedTileColor: Color.fromARGB(50, 160, 185, 198),
                        onLongPress: () {
                          context.read<MessageBloc>().add(
                              new SelectMessageEvent(state.messages[index]));
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
                                color: (state.messages[index].type == "envoyer")
                                    ? Color.fromARGB(20, 0, 255, 0)
                                    : Color.fromARGB(50, 229, 194, 192),
                                child: Text("${state.messages[index].content}"),
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
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
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
      ),
    );
  }
}
