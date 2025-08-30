

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Presentation/cubits/news_cubit/newCubit.dart';
import 'package:news/data/datasource/remote/news/types.dart';

class CategoryCard extends StatelessWidget{
  final String imagePath;
  final String categoryName;
  final NewsTypes type;
  final void Function() callback;
  final bool isActive;

  const CategoryCard({super.key,required this.imagePath,required this.categoryName ,required this.type,required this.callback, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback();
        context.read<NewCubit>().startLoadNews(type, 1, 10);
      },
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.fill ,image: AssetImage(imagePath)),
          borderRadius: BorderRadius.circular(16),
            border: isActive ? Border.all(
            color: Colors.blueAccent,
              width: 3
        ) : Border.all(color: Colors.white)
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