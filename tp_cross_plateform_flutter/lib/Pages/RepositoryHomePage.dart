import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'RepositoryShow.dart';

import 'dart:convert';

class RepositoryHomePage extends StatefulWidget {
  @override
  _RepositoryHomePageState createState() => _RepositoryHomePageState();
}

class _RepositoryHomePageState extends State<RepositoryHomePage> {
  String query;

  TextEditingController queryTextEditingController =
      new TextEditingController();

  ScrollController scrollController = new ScrollController();

  dynamic data;
  int currentPage = 0;
  int totalPage = 0;
  int pageSize = 20;
  List<dynamic> items = [];

  void _search(String query) {
    var _host = "api.github.com";
    var _param = {
      "q": query,
      "per_page": "${pageSize}",
      "page": "${currentPage}"
    };
    var _path = "/search/users";
    Uri url = Uri.https(_host, _path, _param);
    http.get(url).then((response) {
      setState(() {
        this.data = json.decode(response.body);
        items.addAll(data['items']);
        if (data['total_count'] % pageSize == 0) {
          totalPage = data['total_count'] ~/ pageSize;
        } else {
          totalPage = (data['total_count'] / pageSize).floor() + 1;
        }
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          if (currentPage < totalPage - 1) {
            ++currentPage;
            _search(query);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${query} Repositories ${currentPage} : ${totalPage}'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        this.query = value;
                      });
                    },
                    controller: queryTextEditingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  padding: EdgeInsets.all(20),
                )),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      items = [];
                      currentPage = 0;
                      this.query = queryTextEditingController.text;
                      _search(query);
                    });
                  },
                )
              ],
            ),
            Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          height: 3,
                          color: Colors.blue,
                        ),
                    controller: scrollController,
                    itemCount: (data == null) ? 0 : items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RepositoryShow(
                                          login: items[index]['login'],
                                          avatarUrl: items[index]['avatar_url'],
                                        )));
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        items[index]['avatar_url']),
                                    radius: 30,
                                  ),
                                  SizedBox(width: 20),
                                  Text("${items[index]['login']}"),
                                ],
                              ),
                              CircleAvatar(
                                child: Text("${items[index]['score']}"),
                              )
                            ],
                          ));
                    }))
          ],
        ),
      ),
    );
  }
}
