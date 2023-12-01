import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'change_password_page.dart';
import 'change_email_page.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Account Page")
      ),
      body: SafeArea(
       // child: Center(
         child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),

            child: Container(

              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    // User email and change email option
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AppBar(
                        backgroundColor: Colors.blue,
                        title:  Text("User Email: " + user.email!,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            )
                        )
                        ),
                      ),


                    const SizedBox(height: 10,),

                    //change email button
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangeEmailPage();
                                },
                              ),
                            );
                          },
                          child: Text("Change Email",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          )
                      ),
                    ),

                    const SizedBox(height: 10,),

                  // Change password button
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangePasswordPage();
                                },
                              ),
                            );
                          },
                          child: Text("Change Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          )
                      ),
                    ),

                    const SizedBox(height: 200,),

                    //sign out
                    SizedBox(
                      width: 150,
                      height: 60,
                      child: ElevatedButton(
                          onPressed: signUserOut,
                          child: Text("Sign Out",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )
                          )
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

      ),
    );

  }
}

