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
      appBar: AppBar(

        title: const Text("Account Page")
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),

            child: Column(
              children: [


              const SizedBox(height: 45,),

                // User email and change email option
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppBar(
                    title:  Text("User Email: " + user.email!,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        )
                    )
                    ),
                  ),


                const SizedBox(height: 5,),

                //change email button
                SizedBox(
                  width: 120,
                  height: 40,
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
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          )
                      ),
                      style: ElevatedButton.styleFrom(
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
                  height: 40,
                  child: ElevatedButton(
                      onPressed: (){
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
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ))
                      ,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                      )
                  ),
                ),

                const SizedBox(height: 25,),

                //sign out
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: signUserOut,
                      child: Text(
                          "Sign Out",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        )
                      ),
                      style: ElevatedButton.styleFrom(
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
    );

  }
}

