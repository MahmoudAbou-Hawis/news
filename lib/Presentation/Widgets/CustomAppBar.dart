


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget
{
  final String firstWordAppTitle;
  final String secondWordAppTitle;

  const CustomAppBar({super.key,required this.firstWordAppTitle, this.secondWordAppTitle = '',});



  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[Text(
        firstWordAppTitle
        ,style: TextStyle(
        color:  Colors.black,
        fontWeight: FontWeight.w500,
          fontSize:20

      )),
        Text(
            secondWordAppTitle
            ,style: TextStyle(
            color:  Colors.orangeAccent,
            fontWeight: FontWeight.w500,
            fontSize:20

        )),
      ],
    );
  }


}