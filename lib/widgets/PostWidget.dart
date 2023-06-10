
import 'package:flutter/material.dart';
import 'package:us_rowing/models/FeedModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/PostDetailView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class PostWidget extends StatelessWidget {

  final String title;
  final double border;
  final FeedModel post;
  final String userId;


  PostWidget({required this.title,this.border=4, required this.post,required this.userId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: colorGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(border),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: CachedImage(image: post.media.length==0?'':ApiClient.baseUrl+post.media[0],radius: 20,placeHolder: IMG_POST_PLACEHOLDER,),
                ),
              ),
              Positioned(
                bottom: 0,
                  left: 0,
                  right: 0,
                  child:Container(
                    decoration: BoxDecoration(
                      color: colorBlack.withOpacity(0.8),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(10),
                    child:Center(child: Text(title,style: TextStyle(color: colorWhite),)),
                  )
              )
            ],

          ),

        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDetailView(userId: userId, postId: post.sId)));
      },
    );
  }

}