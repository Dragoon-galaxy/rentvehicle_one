// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentvehicle_one/Customer/customer_login.dart';

class NavigationDrawers extends StatefulWidget {
  final String initialUserName;
  final String initialEmail;
  const NavigationDrawers(
      {super.key, required this.initialEmail, required this.initialUserName});

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawers> {
  late String userName;
  late String email;

  @override
  void initState() {
    super.initState();
    userName = widget.initialUserName;
    email = widget.initialEmail;
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CustomerLoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error signing out : $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.account_circle, size: 50),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('My Dashboard'),
            onTap: () {
              // Navigate to My Dashboard page
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Navigate to Notifications page
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('My Documents'),
            onTap: () {
              // Navigate to My Documents page
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Refer & Earn'),
            onTap: () {
              // Navigate to Refer & Earn page
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              // Navigate to About Us page
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to Settings page
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              _signOut();
            },
          ),
        ],
      ),
    );
  }
}