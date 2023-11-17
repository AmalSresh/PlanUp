import 'package:cpsc_362_project/components/calendar_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

    class HomePage extends StatefulWidget {
       const HomePage({super.key});

       @override
       State<HomePage> createState() => _HomePageState();
    }

    class _HomePageState extends State<HomePage>{
      //share calendar method
       void shareCalendar() async{
         //show loading circle
         showDialog(
           context: context,
           builder: (context) {
             return const Center(
               child: CircularProgressIndicator(),
             );
           }
           );
       }
      final user = FirebaseAuth.instance.currentUser!;

      // sign user out method
      void signUserOut() {
        FirebaseAuth.instance.signOut();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
              actions: [
                IconButton(
                    onPressed: signUserOut,
                    icon: const Icon(Icons.logout)
                ),
                CalendarButton(
                  onTap: () {},
                ),//the share calendar button
              ],
          ),
          body: Center(
              child: Text(
                "Logged In As: ${user.email!}",
                style: const TextStyle(fontSize:20),
            )
          ),
        );
      }
    }