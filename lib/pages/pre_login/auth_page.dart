//Will show login screen or homepage depending on authentication status
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_or_register_page.dart';
import '../app_pages/page_directory.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot)
          {
            //user is logged in
            if (snapshot.hasData) {
                return PageDirectory();
              }
            //User is NOT logged in
            else {
              return const LoginOrRegisterPage();
            }
          },
      ),
    );
  }
}
