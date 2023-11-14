//UI for registration page and username/password text field controllers
import 'package:cpsc_362_project/components/my_button.dart';
import 'package:cpsc_362_project/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterPage extends StatefulWidget
{
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  //sign user un method
  void signUserUp() async {
    //show loading circle
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    );

    //try creating user
    try {
      if(passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);
      }
        else if(passwordController.text != confirmPasswordController.text) {
          //pop loading circle and show error message
        Navigator.pop(context);
        wrongCredentialMessage("Passwords don't match. Confirm password again.");
        print("passwords don't match");
        //Navigator.pop(context);
        }
    } on FirebaseAuthException catch (e){
      //pop loading circle
      Navigator.pop(context);
      //show error message, passwords don't match
      if (e.code == 'weak-password') {
        wrongCredentialMessage(e.code);
      } else if (e.code == 'email-already-in-use') {
        wrongCredentialMessage(e.code);
      }
    } catch (e) {
      print(e);
    }
  }

  void wrongCredentialMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Center(
            child:  Text(
                  message,
                style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              ),
            ),
          );
      },
    );
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center (
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),

              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  //logo

                  Image.asset('lib/images/logoFinal.png', height: 100,),
                  //welcome
                  const SizedBox(height: 40),
                  const Text(
                    'Let\'s make you a new account!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 25),
                  //email text
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 25),

                  //password
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),

                  //confirm password
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  const SizedBox(height: 25),

                  //sign in button
                  MyButton(
                    text: "Register",
                    onTap: signUserUp,
                  ),

                  //continue with google
                  const SizedBox(height: 50),

                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child:Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  SignInButton(
                    Buttons.Google,
                    text: "Sign in with Google",
                    onPressed: () {},
                  ),

                  const SizedBox(height: 25),

                  //register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white)),
                      const  SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}