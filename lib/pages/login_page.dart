//UI for login page and username/password text field controllers
import 'package:cpsc_362_project/components/my_button.dart';
import 'package:cpsc_362_project/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class LoginPage extends StatelessWidget
{
  LoginPage({super.key});

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center (
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
        //logo

                Image.asset('lib/images/logoFinal.png', height: 100,),
        //welcome
                const SizedBox(height: 40),
                const Text(
                  'Welcome back you\'ve been missed!',
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

                const SizedBox(height: 10),
        //forgot password
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.0),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                    Text('Forgot Password',
                      style: TextStyle(color: Colors.black),
                      ),
                    ]
                  ),
                ),

                const SizedBox(height: 25),
        //sign in button
                 MyButton(
                  onTap: signUserIn,
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    SizedBox(width: 4),
                    Text('Register now',
                    style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold,
                    ),
                    ),
                  ],
                ),
            ],
          )
        ),
      ),
    );
  }

}