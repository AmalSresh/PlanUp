import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(

          title: const Text("Account Page"),
          actions: [
          IconButton(
          onPressed: signUserOut,
          icon: const Icon(Icons.logout)
         ),
        ],
      ),
    );

  }
}

