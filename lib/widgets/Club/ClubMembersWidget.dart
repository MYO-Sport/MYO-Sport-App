import 'package:flutter/material.dart';
import 'package:us_rowing/models/TeamInfoModel.dart';
import 'package:us_rowing/models/TeamMembersInfoModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/ClubMebmerView.dart';
import 'package:us_rowing/widgets/Club/MembersInfoWidget.dart';

class ClubMembersWidget extends StatefulWidget {
  final TeamInfoModel teamDetails;
  final String userId;

  ClubMembersWidget({required this.teamDetails,required this.userId});
  @override
  _ClubMembersWidgetState createState() => _ClubMembersWidgetState();
}

class _ClubMembersWidgetState extends State<ClubMembersWidget> {
  late String teamMembersName = '';
  late List<TeamMembersInfoModel> teamMembers = widget.teamDetails.teamMembersInfo;
  late String teamMembersImage = '';
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
                Icon(Icons.ac_unit,color: colorBlue,size: 16,),
                SizedBox(width: 10,),
                Text(widget.teamDetails.teamName),
              ],
            ),
          ),
          teamMembers.length==0?
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Team Members',style: TextStyle(color: colorGrey,fontSize: 12),),
                ),
              ):
          GridView.builder(
            padding:
            EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            shrinkWrap: true,
            primary: false,
            itemCount: teamMembers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 1), itemBuilder: (BuildContext context, int index) {
            TeamMembersInfoModel member=teamMembers[index];
            return MembersInfoWidget(
              memberImage: member.profileImage,
              memberName: member.username, userId: widget.userId, memberId: member.sId, memberEmail: ''
              ,
            );
          },

          ),

        ],
      ),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClubMemberView(clubName: widget.teamDetails.teamName,members: [],userId: widget.userId,)));
      },
    );
  }
}