import 'package:flutter/material.dart';
import 'package:us_rowing/models/NotificationModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/views/CoachView/fragments/CoachChatViewFragment.dart';
import 'package:us_rowing/views/PostDetailView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class NotificationWidget extends StatelessWidget {
  final String userId;
  final NotificationModel notification;

  NotificationWidget({required this.userId, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CachedImage(image: ApiClient.baseUrl + notification.createrImage,
                  imageHeight: 50.0,
                  radius: 6,
                  imageWidth: 50,),
                Expanded(
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(text: notification.createrName + '\t',
                        style: TextStyle(color: colorBlack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: notification.message,
                            style: TextStyle(color: colorGrey,
                                fontSize: 12, fontWeight: FontWeight.w300),),
                        ],
                      ),
                    )
                ),
                notification.postMediaType == postImg ?
                CachedImage(
                  image: ApiClient.baseUrl+notification.postMedia[0], imageHeight: 50.0, radius: 6, imageWidth: 50,) :
                notification.postMediaType == postVideo ?
                Container(decoration: BoxDecoration(
                  color: colorBlack,
                  borderRadius: BorderRadius.circular(6),

                ),
                  child: Center(child: Icon(
                    Icons.play_arrow_rounded, color: Colors.white,),),
                ):
                notification.postMediaType==postFile?
                Container(decoration: BoxDecoration(
                  color: colorGrey,
                  borderRadius: BorderRadius.circular(6),

                ),
                  child: Center(child: Text(
                    'PDF', style: TextStyle(color: colorDarkRed),),),
                ):SizedBox(),
              ],
            ),
          ),
          onTap: (){
            if(notification.type=='1'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDetailView(userId: userId, postId: notification.postId)));
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CoachChatViewFragment(workoutImage: '',)));
            }
          },
        ),
        Divider(height: 0,),
      ],
    );
  }
}