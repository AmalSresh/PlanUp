//UI for textfield and  parameters
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller, //takes user input
    required this.hintText,   //tells user what should go in the box
    required this.obscureText, //if user chooses they can show what they type or hide it
  });

  @override
  Widget build(BuildContext context)
  {
    return  Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,

          ),
        )
    );
  }
}