// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_board_app/settings_page.dart';
import 'firebase_options.dart';
import 'messageBoard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class homepage extends StatefulWidget {
  final String email;
  const homepage({super.key, required this.email});
  @override
  State<homepage> createState() => _HomepageState(email);
}

class _HomepageState extends State<homepage> {
  late String email;
  _HomepageState(this.email);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            child: Text("Settings"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  leading: Image(image: AssetImage('assets/gaming.png')),
                  title: TextButton(
                      child: const Text('Gaming Message Board'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => messageBoard(
                                    board: 'gaming', email: email)));
                      }),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Image(image: AssetImage('assets/studyGroup.png')),
                  title: TextButton(
                      child: const Text('Study Message Board'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => messageBoard(
                                    board: 'study', email: email)));
                      }),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Image(image: AssetImage('assets/gym.png')),
                  title: TextButton(
                      child: const Text('Gym Message Board'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    messageBoard(board: 'gym', email: email)));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
