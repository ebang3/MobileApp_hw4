// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:message_board_app/main.dart';
import 'firebase_options.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signOut() async {
    await _auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Signed out successfully'),
    ));
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void passwordChange() {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
            padding: EdgeInsets.fromLTRB(
              15,
              15,
              15,
              MediaQuery.of(context).viewInsets.bottom + 80,
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                      controller: _oldPasswordController,
                      decoration:
                          const InputDecoration(labelText: 'Old Password'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your old password';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _newPasswordController,
                      decoration:
                          const InputDecoration(labelText: 'New Password'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your new password';
                        }
                        return null;
                      }),
                  TextFormField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                          labelText: 'Confirm New Password'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please confirm your new password';
                        }
                        return null;
                      }),
                  ElevatedButton(
                      onPressed: () {
                        _oldPasswordController.clear();
                        _newPasswordController.clear();
                        _confirmPasswordController.clear();
                        Navigator.pop(context);
                      },
                      child: Text('Change Password')),
                ])));
  }

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
                            onPressed: () {
                              passwordChange();
                            },
                          ))),
                  Card(
                      child: ListTile(
                          leading: Icon(Icons.reply),
                          title: TextButton(
                            child: const Text('Logout'),
                            onPressed: () {
                              _signOut();
                            },
                          ))),
                ],
              )),
        )),
      ),
    );
  }
}
