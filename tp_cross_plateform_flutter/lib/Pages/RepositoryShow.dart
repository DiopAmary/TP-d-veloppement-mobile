import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepositoryShow extends StatefulWidget {
  String login;
  String avatarUrl;
  RepositoryShow({this.login, this.avatarUrl});

  @override
  _RepositoryShowState createState() => _RepositoryShowState();
}

class _RepositoryShowState extends State<RepositoryShow> {
  dynamic dataRepositories = [];

  @override
  void initState() {
    super.initState();
    loadRepositories();
  }

  void loadRepositories() async {
    /* var _host = "api.github.com";
    var _path = "/search/users/${widget.login}/repos";
    Uri url = Uri.https(_host, _path); */

    Uri url = Uri.parse("https://api.github.com/users/${widget.login}/repos");

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        this.dataRepositories = json.decode(response.body);
      });
    }
    /* http.get(url).then((response) {
      setState(() {
        print(url);
        this.dataRepositories = json.decode(response.body);
      });
    }).catchError((onError) {
      print(onError);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.avatarUrl),
          )
        ],
        title: Text('${widget.login} repositories'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) =>
            ListTile(title: Text("${dataRepositories[index]["name"]}")),
        separatorBuilder: (context, index) => Divider(
          height: 3,
          color: Colors.blue,
        ),
        itemCount: (dataRepositories == null) ? 0 : dataRepositories.length,
      ),
    );
  }
}
