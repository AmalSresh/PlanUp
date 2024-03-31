import 'package:flutter/material.dart';
import 'package:cpsc_362_project/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    var result = await FirebaseAuth
        .instance.fetchSignInMethodsForEmail(emailController.text.trim());
    if (result.isNotEmpty) {
      try {
            showDialog(context: context, builder: (context){
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            );
            await FirebaseAuth
                .instance.sendPasswordResetEmail(
                email: emailController.text.trim());
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.blue,
                  title: Center(
                    child: Text(
                      "Password reset link sent! Check your email",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                ),
              ),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        print(e);
        print("error");
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: Center(
                child: Text(
                  e.code,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      }
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Center(
              child: Text(
                "this email does not exist, try again",
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
                "Enter Your Email and we will send you a password reset link",
              textAlign: TextAlign.center,),
            ),

            SizedBox(height: 10),

            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            MaterialButton(
              onPressed: () {
                passwordReset();
                },
              child: Text("Reset Password"),
              color: Colors.blue,
            )
          ],
        ),
    );
  }
}
