import 'package:flutter/material.dart';
import 'package:us_rowing/models/MemberModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:us_rowing/widgets/MemberWidget.dart';

class ClubMemberView extends StatefulWidget {
  final String clubName;
  final List<MemberModel> members;
  final String userId;

  ClubMemberView({required this.clubName, required this.members,required this.userId});

  @override
  _ClubMemberViewState createState() => _ClubMemberViewState();
}

class _ClubMemberViewState extends State<ClubMemberView> {

  List<MemberModel> showMemebrs=[];

  @override
  void initState() {
    super.initState();
    showMemebrs.addAll(widget.members);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            color: colorPrimary,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 70.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: colorWhite,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  widget.clubName,
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: colorWhite.withOpacity(0),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          InputFieldSuffix(
            text: 'Search here . . .',
            suffixImage: 'assets/images/filter-icon-for-bar.png',
            onChange: onSearch,
          ),
          SizedBox(
            height: 10.0,
          ),
          Flexible(child: ListView.builder(
            itemCount: showMemebrs.length,
              itemBuilder: (context, index) {
              MemberModel member=showMemebrs[index];
            return MemberWidget(name: member.username,image: member.profilePic,email: member.email,id: member.sId,userId: widget.userId,);
          }))
        ],
      ),
    );
  }

  onSearch(String text){
    if(text.isNotEmpty){
      showMemebrs.clear();
      for(MemberModel athlete in widget.members){
        if(athlete.username.toLowerCase().contains(text.toLowerCase())){
          showMemebrs.add(athlete);
        }
      }
      setState(() {});
    }else{
      showMemebrs.clear();

      setState(() {
        showMemebrs.addAll(widget.members);
      });
    }
  }
}
