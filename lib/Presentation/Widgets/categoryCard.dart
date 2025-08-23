

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget{
  final String imagePath;
  final String categoryName;


  const CategoryCard({super.key,required this.imagePath,required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.fill ,image: AssetImage(imagePath)),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Align(
          alignment: Alignment.center,

          child: Text(categoryName,style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),) ,
        ),
      ),
    );
  }

}