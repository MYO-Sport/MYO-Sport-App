import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';

class ChatWidget extends StatelessWidget {
  final String name;
  final String image;

  ChatWidget({this.image='',this.name=''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
      child: InkWell(
        child: Container(
          height: 80.0,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                      placeholder: (context, url) => Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                            new AlwaysStoppedAnimation<Color>(colorWhite),
                          ),
                        ),
                        width: 90.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0))),
                      ),
                      errorWidget: (context, url, error) => Material(
                        child: Image.asset(
                          IMG_PLACEHOLDER,
                          width: 90.0,
                          height: 80.0,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        clipBehavior: Clip.hardEdge,
                      ),
                      imageUrl: image,
                      width: 90.0,
                      height: 80.0,
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 5,),
              Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name,style: TextStyle(color: colorBlack,fontWeight: FontWeight.w500),maxLines: 1,),
                      SizedBox(height: 10,),
                      Text('Description ',style: TextStyle(color: colorGrey,fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.clip,),
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('10:47 AM',style: TextStyle(color: colorBlack,fontSize: 12),),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(child: Text('2',style: TextStyle(color: colorWhite,fontSize: 12),)),
                  ),
                  SizedBox(height: 10,),
                ],
              )
            ],
          ),
        ),
        onTap: (){
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatView(currentUserId: '1', peerId: '1-2', peerName: 'Kamran', peerAvatar: image,roomId: '',)));
        },
      ),
    );
  }
}