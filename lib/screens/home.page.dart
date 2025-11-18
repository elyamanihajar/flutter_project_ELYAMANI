import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home page",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Center(
        child: Text(
          textAlign: TextAlign.center,
          "Welcome to the Home page",
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orangeAccent,
                    Colors.deepOrange,
                    Colors.brown,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/avatar2.PNG"),
                    radius: 30,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "ELYAMANI Hajar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "hajarelyamani19@gmail.com",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.coronavirus_outlined, color: Colors.teal),
              title: Text(
                "Covid Tracker",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Divider(color: Colors.brown, thickness: 2),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.chat, color: Colors.teal),
              title: Text(
                "EMSI ChatBot",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Divider(color: Colors.brown, thickness: 2),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.person, color: Colors.teal),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Divider(color: Colors.brown, thickness: 2),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.settings, color: Colors.teal),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Divider(color: Colors.brown, thickness: 2),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/login');
                //Navigator.pop(context);
              },
              leading: Icon(Icons.logout, color: Colors.teal),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Divider(color: Colors.brown, thickness: 2),
          ],
        ),
      ),
    );
  }
}
