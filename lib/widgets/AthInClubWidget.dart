
import 'package:flutter/material.dart';
import 'package:us_rowing/models/MemberModel.dart';
import 'package:us_rowing/models/PlayerModel.dart';
import 'package:us_rowing/views/ClubMebmerView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

import 'AthleteWidget.dart';

class AthInClubWidget extends StatelessWidget {

  final PlayerModel player;
  final String userId;

  AthInClubWidget({required this.player,required this.userId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CachedImage(
                  image: player.image,
                  imageWidth: 16,
                  imageHeight: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  player.clubName,
                ),
              ],
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            shrinkWrap: true,
            primary: false,
            itemCount: player.members.length>5?5:player.members.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 1),
            itemBuilder: (BuildContext context, int index) {
              MemberModel member=player.members[index];
              return AthleteWidget(
                name: member.username,
                image: member.profilePic,
                email: member.email,
                id: member.sId,
                userId: userId,
              );
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ClubMemberView(clubName: player.clubName,members: player.members,userId: userId,)));
      },
    );
  }

}
