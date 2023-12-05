import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget{
   final String? hint;
   final TextEditingController? controller;
  CustomInput({this.hint,this.controller});
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:50,
      width: 500,
      padding: const EdgeInsets.only(left:20,right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFE1E1E1),

      ),
      child:  TextField(
         controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ) ,
      ),
    );
  }
}