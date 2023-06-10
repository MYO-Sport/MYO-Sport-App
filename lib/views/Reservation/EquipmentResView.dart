
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/Reservation/ExploredView.dart';
import 'package:us_rowing/views/Reservation/ReservedView.dart';


class EquipmentResView extends StatefulWidget {

  final String clubId;
  final String clubName;
  final String userId;

  EquipmentResView({required this.clubId,required this.clubName, required this.userId});

  @override
  _EquipmentResViewState createState() => _EquipmentResViewState();
}

class _EquipmentResViewState extends State<EquipmentResView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colorBackgroundLight,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AppBar(
              backgroundColor: colorWhite,
              leading: SizedBox(),
              leadingWidth: 0,
              title: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorPrimary,
                        size: 18
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    Text('Equipment Reservation',style: TextStyle(fontSize: 18,color: colorBlack),),
                    SizedBox(height: 18,width: 18,)
                  ], ),
              ),
              centerTitle: true,
              bottom: TabBar(
                unselectedLabelColor: colorGrey,
                labelColor: colorPrimary,
                unselectedLabelStyle: TextStyle(color: colorGrey,fontSize: 14),
                labelStyle: TextStyle(color: colorPrimary,fontSize: 14),
                indicatorColor: colorPrimary,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicatorWeight: 2,
                indicator: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/tab_background.png'),fit: BoxFit.fill),
                ),
                tabs: [
                  Tab(
                    // icon: Container(
                    //   padding: EdgeInsets.all(10),
                    //   child: Text('Explore',style: TextStyle(color: colorBlack),),
                    // ),
                    text: 'Explore',
                  ),
                  Tab(
                    // icon: Container(
                    //   padding: EdgeInsets.all(10),
                    //   child: Text('Reserved',style: TextStyle(color: colorBlack),),
                    // ),
                    text: 'Reserved',
                  ),
                ],
                isScrollable: false,
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ExploredView(clubId: widget.clubId,userId: widget.userId,),
            ReservedView(userId: widget.userId,)
          ],
        ),
      ),
    );
  }
}
