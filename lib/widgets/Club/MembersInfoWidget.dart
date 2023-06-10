
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/AtheleteDetailView.dart';

class MembersInfoWidget extends StatefulWidget {

  final String memberName;
  final String memberImage;
  final String memberEmail;
  final String memberId;
  final String userId;

  MembersInfoWidget({required this.memberImage,required this.memberName,required this.memberEmail,required this.memberId,required this.userId,});

  @override
  _MembersInfoWidgetState createState() => _MembersInfoWidgetState();
}

class _MembersInfoWidgetState extends State<MembersInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        new AlwaysStoppedAnimation<Color>(colorGrey),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0))),
                  ),
                  errorWidget: (context, url, error) => Material(
                    child: Image.asset(
                      "assets/images/placeholder.jpg",
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    clipBehavior: Clip.hardEdge,
                  ),
                  imageUrl: widget.memberImage,
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 2,),
          Text(widget.memberName,style: TextStyle(color: colorGrey,fontSize: 10),textAlign: TextAlign.center,)

        ],
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AthleteDetailView(athleteName: widget.memberName,email: widget.memberEmail,img: widget.memberImage,athleteId: widget.memberId,userId: widget.userId,)));
      },
    );
  }
}