import 'package:flutter/material.dart';
import 'GalleryData.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String keyword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('${keyword}')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onChanged: (value) {
                setState(() {
                  this.keyword = value;
                });
              },
              onSubmitted: (value) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GalleryData(value)));
              },
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GalleryData(this.keyword)));
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Rechercher'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
