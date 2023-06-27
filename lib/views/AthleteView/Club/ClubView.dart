import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/ClubModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/AllClubsResponse.dart';
import 'package:us_rowing/network/response/AssignedClubsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/Club/ClubWidget.dart';
import 'package:us_rowing/widgets/Club/MyClubWidget.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class ClubView extends StatefulWidget {
  final bool isBack;
  final bool allClubs;

  ClubView({this.isBack = true, this.allClubs = true});
  @override
  _ClubViewState createState() => _ClubViewState();
}

class _ClubViewState extends State<ClubView> {
  bool isLoading = true;

  bool gettingAssignedClubs = true;
  bool searching = false;

  List<ClubModel> assignedClubs = [];
  List<ClubModel> clubs = [];
  List<ClubModel> showAssignedClubs = [];
  List<ClubModel> showClubs = [];
  late String userId;

  bool moreLoadingg = false;
  late ScrollController _scrollController;

  int skip = 0;
  String limit = '10';

  String keyword = "";

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print('scrolling');
      if (!moreLoadingg &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        print('Full Scrolled');
        if (searching) {
          getSearchedAllClubs(++skip, keyword);
        } else {
          getAllClubs(++skip);
        }
      }
    });

    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
      getAssignedClubs();
      getAllClubs(skip);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      resizeToAvoidBottomInset: false,
      appBar: SimpleToolbar(
        title: 'Select Club',
        isBack: widget.isBack,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            InputFieldSuffix(
              text: 'Search club',
              suffixImage: 'assets/images/search.png',
              onChange: onSearch,
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 5),
              child: Text(
                'MY CLUBS',
                style: TextStyle(
                    color: colorBlack, fontSize: 16.0, letterSpacing: 0.5),
              ),
            ),
            gettingAssignedClubs
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Center(child: CircularProgressIndicator()))
                : showAssignedClubs.length == 0
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Center(
                            child: Text(
                          'No Subscribed Clubs',
                          style: TextStyle(color: colorGrey),
                        )))
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: showAssignedClubs.length,
                        itemBuilder: (context, index) {
                          ClubModel club = showAssignedClubs[index];
                          return MyClubWidget(
                            userId: userId,
                            clubId: club.sId,
                            image:
                                ApiClient.mediaImgUrl + club.picture.fileName,
                            name: club.clubName,
                            clubModel: club,
                          );
                        },
                      ),
            widget.allClubs
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 5),
                        child: Text(
                          'CLUBS',
                          style: TextStyle(
                              color: colorBlack,
                              fontSize: 16.0,
                              letterSpacing: 0.5),
                        ),
                      ),
                      isLoading
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Center(child: CircularProgressIndicator()))
                          : showClubs.length == 0
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Center(
                                      child: Text(
                                    'No Clubs',
                                    style: TextStyle(color: colorGrey),
                                  )))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: showClubs.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == showClubs.length) {
                                      if (moreLoadingg) {
                                        _scrollController.jumpTo(
                                            _scrollController
                                                .position.maxScrollExtent);
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Center(
                                              child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator())),
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    } else {
                                      ClubModel club = showClubs[index];
                                      return ClubWidget(
                                        clubId: club.sId,
                                        userId: userId,
                                        name: club.clubName,
                                        image: ApiClient.mediaImgUrl +
                                            club.picture.fileName,
                                        clubModel: club,
                                        onAdd: onAdd,
                                      );
                                    }
                                  })
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  onAdd() {
    showClubs.clear();
    showAssignedClubs.clear();
    setState(() {
      isLoading = true;
      gettingAssignedClubs = true;
    });
    getAssignedClubs();
    skip = 0;
    getAllClubs(skip);
  }

  /*getClubs() async {
    setState(() {
      isLoading = true;
    });
    print('userId' + userId);
    String apiUrl = ApiClient.urlGetClubs + userId;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      ClubsResponse mResponse =
          ClubsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          showClubs.clear();
          showAssignedClubs.clear();
          assignedClubs=mResponse.assignedClubs;
          clubs=mResponse.allClubs;
          showAssignedClubs.addAll(mResponse.assignedClubs);
          showClubs.addAll(mResponse.allClubs);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
    }
  }*/

  getAssignedClubs() async {
    // setState(() {
    //   isLoading = true;
    // });
    //
    //print('userId' + userId);
    String apiUrl = ApiClient.urlGetAssignedClub + userId;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      debugPrint('ERROR: $value');
      setState(() {
        gettingAssignedClubs = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      AssignedClubsResponse mResponse =
          AssignedClubsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          // showClubs.clear();
          showAssignedClubs.clear();
          assignedClubs = mResponse.assignedClubs;
          // clubs=mResponse.allClubs;
          showAssignedClubs.addAll(mResponse.assignedClubs);
          // showClubs.addAll(mResponse.allClubs);
          gettingAssignedClubs = false;
        });
      } else {
        setState(() {
          gettingAssignedClubs = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Error Occured Try Again Later');
    }
  }

  getSearchedAssignedClubs(String keyword) async {
    // setState(() {
    //   isLoading = true;
    // });
    print('userId' + userId);
    String apiUrl = ApiClient.urlGetSearchedAssignedClub + userId;

    final response = await http.post(Uri.parse(apiUrl),
        body: {'keyWord': keyword}).catchError((value) {
      setState(() {
        gettingAssignedClubs = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      AssignedClubsResponse mResponse =
          AssignedClubsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          // showClubs.clear();
          showAssignedClubs.clear();
          assignedClubs = mResponse.assignedClubs;
          // clubs=mResponse.allClubs;
          showAssignedClubs.addAll(mResponse.assignedClubs);
          // showClubs.addAll(mResponse.allClubs);
          gettingAssignedClubs = false;
        });
      } else {
        setState(() {
          gettingAssignedClubs = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
    }
  }

  getAllClubs(int mSkip) async {
    // setState(() {
    //   isLoading = true;
    // });
    // print('userId' + userId);
    String apiUrl = ApiClient.urlGetAllClubs + userId;

    final response = await http.post(Uri.parse(apiUrl),
        body: {'skip': '$mSkip', 'limit': limit}).catchError((value) {
      print('Error: $value');
      setState(() {
        moreLoadingg = false;
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Error Occured. Try again later.');
      return value;
    });
    // print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      AllClubsResponse mResponse =
          AllClubsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          // showClubs.clear();
          // showAssignedClubs.clear();
          // assignedClubs=mResponse.assignedClubs;
          clubs = mResponse.allClubs;
          // showAssignedClubs.addAll(mResponse.assignedClubs);
          showClubs.addAll(mResponse.allClubs);
          moreLoadingg = false;
          isLoading = false;
        });
      } else {
        setState(() {
          moreLoadingg = false;
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection ABC');
    }
  }

  getSearchedAllClubs(int mSkip, String keyword) async {
    // setState(() {
    //   isLoading = true;
    // });
    print('userId' + userId);
    print('skip $mSkip');
    print('limit $limit');
    String apiUrl = ApiClient.urlGetSearchedAllClub + userId;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'skip': '$mSkip',
      'limit': limit,
      'keyWord': keyword
    }).catchError((value) {
      setState(() {
        moreLoadingg = false;
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      AllClubsResponse mResponse =
          AllClubsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          // showClubs.clear();
          // showAssignedClubs.clear();
          // assignedClubs=mResponse.assignedClubs;
          clubs = mResponse.allClubs;
          // showAssignedClubs.addAll(mResponse.assignedClubs);
          showClubs.addAll(mResponse.allClubs);
          moreLoadingg = false;
          isLoading = false;
        });
      } else {
        setState(() {
          moreLoadingg = false;
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
    }
  }

  /*onSearch(String text){
    if(text.isNotEmpty){
      showAssignedClubs.clear();
      showClubs.clear();
      for(ClubModel club in assignedClubs){
        if(club.clubName.toLowerCase().contains(text.toLowerCase())){
          showAssignedClubs.add(club);
        }
      }
      for(ClubModel club in clubs){
        if(club.clubName.toLowerCase().contains(text.toLowerCase())){
          showClubs.add(club);
        }
      }
      setState(() {});
    }else{
      showAssignedClubs.clear();
      showClubs.clear();

      setState(() {
        showAssignedClubs.addAll(assignedClubs);
        showClubs.addAll(clubs);
      });
    }
  }*/

  onSearch(String text) {
    if (text.isNotEmpty) {
      showAssignedClubs.clear();
      showClubs.clear();
      skip = 0;
      setState(() {
        keyword = text;
        searching = true;
        isLoading = true;
        gettingAssignedClubs = true;
      });

      getSearchedAllClubs(skip, text);
      getSearchedAssignedClubs(text);
    } else {
      showAssignedClubs.clear();
      showClubs.clear();

      setState(() {
        searching = false;
        isLoading = true;
        gettingAssignedClubs = true;
      });

      skip = 0;
      getAssignedClubs();
      getAllClubs(skip);
    }
  }
}
