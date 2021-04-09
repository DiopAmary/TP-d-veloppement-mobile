import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Text(
          'Welcome Home',
          style: TextStyle(fontSize: 35, color: Colors.black),
        ),
      ),
      /*  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/originals/4b/58/35/4b583589b05ee1a62aaebd49964148fb.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ), */
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/4b/58/35/4b583589b05ee1a62aaebd49964148fb.jpg')),
                  Text(
                    'Mon Application',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.white, Colors.blue])),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/");
              },
              leading: Icon(Icons.home_outlined),
              title: Text(
                'Accueil',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/repositories");
              },
              leading: Icon(Icons.search_off_outlined),
              title: Text(
                'Repositories',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(
              color: Colors.blue,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/galerie");
              },
              leading: Icon(Icons.image_search_outlined),
              title: Text(
                'Galerie',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/counter");
              },
              leading: Icon(Icons.calculate_outlined),
              title: Text(
                'Compteur',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
