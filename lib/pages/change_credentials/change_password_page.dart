import 'package:flutter/material.dart';
import 'package:cpsc_362_project/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app_pages/account_page.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}
class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  @override
  final user = FirebaseAuth.instance.currentUser!;

  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> changePassword() async {
    if(passwordController.text == confirmPasswordController.text)
      {
        try{
              showDialog(context: context, builder: (context){
                return const Center(
                  child: CircularProgressIndicator(),
                );
            },
          );
          await user?.updatePassword(passwordController.text);
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.blue,
                title: Center(
                  child: Text(
                    "New Password Has Been Set!",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          );
        } on FirebaseAuthException catch (e)
    {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Center(
              child: Text(
                e.code,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );
    }
      }
    else{
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Center(
              child: Text(
                "Passwords don't match, try again",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Change your password",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,),
          ),

          SizedBox(height: 10),

          //Enter new password

          MyTextField(
            controller: passwordController,
            hintText: 'New Password',
            obscureText: true,
          ),

          SizedBox(height: 10),

          //Confirm new password

          MyTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm New Password',
            obscureText: true,
          ),

          // Change password confirmation button

          MaterialButton(
            onPressed: () {
              changePassword();
            },
            child: Text("Change Password"),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
