// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: Colors.lightGreen,
            leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            )),
        body: (SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Card(
                      child: ListTile(
                          leading: Icon(Icons.manage_accounts_outlined),
                          title: TextButton(
                            child: const Text('Change Email Address'),
                            onPressed: () {},
                          ))),
                  Card(
                      child: ListTile(
                          leading: Icon(Icons.lock),
                          title: TextButton(
                            child: const Text('Change Password'),
                            onPressed: () {},
                          ))),
                  Card(
                      child: ListTile(
                          leading: Icon(Icons.face),
                          title: TextButton(
                            child: const Text('Change Name'),
                            onPressed: () {},
                          ))),
                  Card(
                      child: ListTile(
                          leading: Icon(Icons.reply),
                          title: TextButton(
                            child: const Text('Logout'),
                            onPressed: () {},
                          ))),
                ],
              )),
        )),
      ),
    );
  }
}
