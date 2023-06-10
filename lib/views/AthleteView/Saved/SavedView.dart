import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/views/AthleteView/Saved/SavedDocView.dart';
import 'package:us_rowing/views/AthleteView/Saved/SavedMediaView.dart';
import 'package:us_rowing/views/AthleteView/Saved/SavedPostView.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class SavedView extends StatefulWidget {
  @override
  _SavedViewState createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  bool isLoading = true;


  String userId='';

  @override
  void initState() {
    super.initState();
    getUser().then((value){
      setState(() {
        userId=value.sId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleToolbar(title: 'Saved'),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: colorBackgroundLight,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                color: colorWhite,
                child: Center(
                  child: TabBar(
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
                        //   child: Text(
                        //     'Feed',
                        //     style: TextStyle(color: colorBlack),
                        //   ),
                        // ),
                        text: 'Feed',
                      ),
                      Tab(
                        // icon: Container(
                        //   padding: EdgeInsets.all(10),
                        //   child: Text(
                        //     'Media',
                        //     style: TextStyle(color: colorBlack),
                        //   ),
                        // ),
                        text: 'Media',
                      ),
                      Tab(
                        // icon: Container(
                        //   padding: EdgeInsets.all(10),
                        //   child: Text(
                        //     'Docs',
                        //     style: TextStyle(color: colorBlack),
                        //   ),
                        // ),
                        text: 'Docs',
                      ),
                    ],
                    isScrollable: false,
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                SavedPostView(isAdmin: false),
                SavedMediaView(isAdmin: false,userId: userId,),
                SavedDocView(id: '', stat: '',userId: userId,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
