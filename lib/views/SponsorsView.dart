import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/SponsorModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/SponsorsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';
import 'package:us_rowing/widgets/SponsorWidget.dart';

class SponsorsView extends StatefulWidget {
  const SponsorsView({Key? key}) : super(key: key);

  @override
  _SponsorsViewState createState() =>
      _SponsorsViewState();
}

class _SponsorsViewState extends State<SponsorsView> {

  List<SponsorModel> sponsors = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser().then((value){
      getSponsors(value.sId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
      appBar: SimpleToolbar(title: 'Sponsors',),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : sponsors.length == 0
          ? Center(
        child: Text('No Sponsors'),
      )
          : SafeArea(
        child: ListView.builder(
            itemCount: sponsors.length,
            itemBuilder: (context,index){
              SponsorModel sponsor=sponsors[index];
              return SponsorWidget(
                sponsor: sponsor,
              );
            }),
      ),
    );
  }

  getSponsors(String userId) async {
    setState(() {
      isLoading = true;
    });
    print('userId' + userId);
    String apiUrl = ApiClient.urlGetSponsors;

    final response = await http
        .post(
      Uri.parse(apiUrl),
    )
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      SponsorsResponse mResponse =
      SponsorsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          sponsors=mResponse.sponsers;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading= false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
