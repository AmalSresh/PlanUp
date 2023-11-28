import 'package:flutter/material.dart';
import 'package:cpsc_362_project/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'account_page.dart';
class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPage();
}
class _ChangeEmailPage extends State<ChangeEmailPage> {

  final emailController = TextEditingController();

  @override
  final user = FirebaseAuth.instance.currentUser!;

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> changeEmail() async {
    try {
      showDialog(context: context, builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      );
      await user?.updateEmail(emailController.text);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Center(
              child: Text(
                "New Email Has Been Set!",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
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

    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         backgroundColor: Colors.blue,
    //         title: Center(
    //           child: Text(
    //             "Passwords don't match, try again",
    //             style: TextStyle(color: Colors.white),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }


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
              "Change your Email",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,),
          ),

          SizedBox(height: 10),

          //Enter new password

          MyTextField(
            controller: emailController,
            hintText: 'New Email',
            obscureText: false,
          ),

          SizedBox(height: 10),

          // Change password confirmation button

          MaterialButton(
            onPressed: () {
              changeEmail();
            },
            child: Text("Change Email"),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
