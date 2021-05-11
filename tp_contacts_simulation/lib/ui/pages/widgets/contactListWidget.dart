import 'package:flutter/material.dart';
import 'package:tp_contacts_simulation/models/contactModel.dart';

class ContactListWidget extends StatelessWidget {
  List<Contact> contacts;
  ContactListWidget({this.contacts});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.pushNamed(context, "/messages",
                arguments: contacts[index]);
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text('${contacts[index].profile}'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("${contacts[index].name}"),
                ],
              ),
              CircleAvatar(
                child: Text("${contacts[index].score}"),
                backgroundColor: Colors.black,
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        height: 2,
        color: Colors.deepPurple,
      ),
    ));
  }
}
