import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsTile extends StatelessWidget {
   String ?imageLink;
  final String newTitle;
  final String subTitle;

   NewsTile({
    super.key,
    required this.imageLink,
    required this.newTitle,
    required this.subTitle,
  }){
    if( imageLink == null || imageLink!.isEmpty){
        imageLink = "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?q=80&w=2669&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: imageLink! ,
              height: 200,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, ul) => Skeletonizer(
                enabled: true,
                effect: const ShimmerEffect(
                  baseColor: Color(0xFFE0E0E0),
                  highlightColor: Color(0xFFF5F5F5),
                  duration: Duration(seconds: 3),
                ),
                child: Skeleton.leaf(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: double.infinity,
                        ),
                      ),

                ),
              ),
            ),
          ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 14),
          title: Text(newTitle,maxLines: 2,),
          subtitle: Text(subTitle,style: TextStyle(color: Colors.grey),maxLines: 3,),
        )
      ],
    );
  }
}
