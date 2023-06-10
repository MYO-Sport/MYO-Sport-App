import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/UpdateProfileResponse.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/AthleteView/Club/ClubView.dart';
import 'package:us_rowing/views/AthleteView/Team/TeamView.dart';
import 'package:us_rowing/views/WorkOutView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/MainWidget.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class MyProfileView extends StatefulWidget {

  @override
  _MyProfileViewState createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {

  File _image = File('');
  bool filesPicked = false;
  String imgUrl='';
  late UserModel user;

  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    getUser().then((value){
      setState(() {
        user=value;
        imgUrl=user.profileImage.replaceAll('\\', '/');
      });
    });

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
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Text(
                'MY PROFILE',
                style: TextStyle(
                    color: colorWhite,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: colorGrey,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  children: [
                    InkWell(
                      child: CachedImage(
                        image: ApiClient.baseUrl+imgUrl,
                        imageHeight: 100,
                        imageWidth: 100,
                        radius: 50,
                        padding: 0,
                      ),
                      onTap: getImage,
                    ),
                    isLoading?
                    Container(child: Center(child: CircularProgressIndicator())):
                    SizedBox(),

                  ],
                )
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: MainWidget(
                text: 'My workout',
                postImage: IMG_FORWARD,
                preImage: IMG_WORKOUT,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WorkOutView()));
                },
              ),
            ),
            SizedBox(height: 25.0,),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 30.0),
              child: MainWidget(
                text: 'My Teams',
                postImage: IMG_FORWARD,
                preImage: IMG_TEAMS,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeamView()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: MainWidget(
                text: 'My Clubs',
                postImage: IMG_FORWARD,
                preImage: IMG_CLUB,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClubView()));
                },
              ),
            ),
            SizedBox(height: 25.0,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30.0),
              child: MainWidget(
                text: 'Logout',
                postImage: IMG_FORWARD,
                preImage: IMG_WHISTLE,
                onPressed: () {
                  logout(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _image = result.paths.map((path) => File(path!)).toList().first;
        filesPicked = true;
      });
    } else {
      updateImage();
      // User canceled the picker
    }
  }


  updateImage() async {
    print('updating image');
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlUpdateDP+user.sId;
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl));
    request.files.add(new http.MultipartFile.fromBytes(
        'profile_image', await _image.readAsBytes(),
        filename: path.basename(_image.path)));
    request.send().then((response) {
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        getResponse(response);
      } else {
        getError(response);
      }
    }).catchError((error) {
      print('Error: ' '$error');
    });
  }

  getResponse(var streamedResponse) async {
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    UpdateProfileResponse mResponse =
    UpdateProfileResponse.fromJson(json.decode(response.body));
    if (mResponse.status) {
      String url=mResponse.profileImage.replaceAll('\\', '/');
      saveImage(url).then((value){
        setState(() {
          imgUrl=url;
        });
      });
    } else {
      MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
    }
  }

  getError(var streamedResponse) async {
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
  }
}
