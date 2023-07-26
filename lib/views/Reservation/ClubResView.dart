import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_rowing/models/club/club_response.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/providers/club_providers/club_provider.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/Club/ClubWidget.dart';
import 'package:us_rowing/widgets/ClubResWidget.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class ClubResView extends StatefulWidget {
  final bool isBack;
  final bool allClubs;

  ClubResView({this.isBack = true, this.allClubs = true});
  @override
  _ClubResViewState createState() => _ClubResViewState();
}

class _ClubResViewState extends State<ClubResView> {
  // ClubProvider? clubProvider;
  // bool isLoading = true;
  // List<Club> assignedClubs = [];
  // List<Club> clubs = [];
  // List<Club> showAssignedClubs = [];
  // List<Club> showClubs = [];
  // late String userId;

  @override
  void initState() {
    super.initState();

    // clubProvider = ClubProvider();
    // clubProvider!.getUserId();
    // getUser().then((value) {
    //   setState(() {
    //     userId = value.sId;
    //   });
    //   getClubs();
    // });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ClubProvider>(context);
    provider.getUserId();

    return Scaffold(
      backgroundColor: colorBackgroundLight,
      resizeToAvoidBottomInset: false,
      appBar: SimpleToolbar(title: 'Select Club'),
      body: Consumer<ClubProvider>(builder: (context, provider, child) {
        return FutureBuilder(
            future: provider.getClubs(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    InputFieldSuffix(
                      text: 'Search club',
                      suffixImage: 'assets/images/search.png',
                      // onChange: onSearch,
                      onChange: () {},
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22.0, vertical: 5),
                      child: Text(
                        'MY CLUBS',
                        style: TextStyle(
                            color: colorBlack,
                            fontSize: 16.0,
                            letterSpacing: 0.5),
                      ),
                    ),
                    provider.isLoading
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Center(child: CircularProgressIndicator()))
                        : provider.assignedClub.length == 0
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Center(
                                    child: Text(
                                  'No Subscribed Clubs',
                                  style: TextStyle(color: colorGrey),
                                )))
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: provider.assignedClub.length,
                                itemBuilder: (context, index) {
                                  AssignedClub club =
                                      provider.assignedClub[index];
                                  return ClubResWidget(
                                    userId: provider.getCurrentUserID,
                                    clubId: club.id,
                                    image: ApiClient.mediaImgUrl +
                                        club.picture.fileName,
                                    clubName: club.clubName,
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
                              provider.isLoading
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: Center(
                                          child: CircularProgressIndicator()))
                                  : provider.allClubs.length == 0
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Center(
                                              child: Text(
                                            'No Clubs',
                                            style: TextStyle(color: colorGrey),
                                          )))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: provider.allClubs.length,
                                          itemBuilder: (context, index) {
                                            AllClub club =
                                                provider.allClubs[index];
                                            return ClubWidget(
                                              clubId: club.id,
                                              userId: provider.getCurrentUserID,
                                              name: club.clubName,
                                              image: ApiClient.mediaImgUrl +
                                                  club.picture.fileName,
                                              clubModel: club,
                                              onAdd: onAdd,
                                            );
                                          })
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              );
            });
      }),
    );
  }

  onAdd() {
    var provider = Provider.of<ClubProvider>(context);
    setState(() {
      provider.isLoading = true;
    });
    // getClubs();
  }

  // getClubs() async {
  //   showClubs.clear();
  //   showAssignedClubs.clear();
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // var userId = '6480c8579d18477baddd9357';
  //   print('userId' + userId);
  //   String apiUrl = ApiClient.urlGetClubs + userId;

  //   final response = await http
  //       .post(
  //     Uri.parse(apiUrl),
  //   )
  //       .catchError((value) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     MySnackBar.showSnackBar(
  //         context, 'Error: ' + 'Check Your Internet Connection');
  //     return value;
  //   });

  //   if (response.statusCode == 200) {
  //     var data = clubResponseFromJson(response.body);

  //     assignedClubs = data.assignedClubs;
  //     clubs = data.allClubs;
  //     showAssignedClubs.addAll(data.assignedClubs);
  //     showClubs.addAll(data.allClubs);
  //     print(showClubs.toString());
  //     isLoading = false;
  //     setState(() {});
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     MySnackBar.showSnackBar(context, 'Error: Please Try Again Later');
  //   }
  // }

  // onSearch(String text) {
  //   if (text.isNotEmpty) {
  //     showAssignedClubs.clear();
  //     showClubs.clear();
  //     for (Club club in assignedClubs) {
  //       if (club.clubName.toLowerCase().contains(text.toLowerCase())) {
  //         showAssignedClubs.add(club);
  //       }
  //     }
  //     for (Club club in clubs) {
  //       if (club.clubName.toLowerCase().contains(text.toLowerCase())) {
  //         showClubs.add(club);
  //       }
  //     }
  //     setState(() {});
  //   } else {
  //     showAssignedClubs.clear();
  //     showClubs.clear();

  //     setState(() {
  //       showAssignedClubs.addAll(assignedClubs);
  //       showClubs.addAll(clubs);
  //     });
  //   }
  // }
}
