import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/UpdateProfileResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/CompleteProfileView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/ProfileWidget.dart';

class CoachProfileView extends StatefulWidget {
  @override
  _CoachProfileViewState createState() => _CoachProfileViewState();
}

class _CoachProfileViewState extends State<CoachProfileView> {
  File _image = File('');
  bool filesPicked = false;
  String imgUrl = '';
  late UserModel user;
  bool loaded = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        user = value;
        imgUrl = user.profileImage.replaceAll('\\', '/');
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
              backgroundColor: colorWhite,
              title: Text(
                'User Profile',
                style: TextStyle(color: colorBlack),
              ),
              centerTitle: true,
              leading: InkWell(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: colorPrimary,
                  size: 18,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.edit,
                      color: colorPrimary,
                      size: 18,
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => CompleteProfileView(
                                    user: user,
                                    update: true,
                                  )))
                          .then((value) {
                        if (value is UserModel) {
                          setState(() {
                            user = value;
                          });
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
      body: loaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
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
                            image: ApiClient.baseUrl + imgUrl,
                            imageHeight: 100,
                            imageWidth: 100,
                            radius: 50,
                            padding: 0,
                          ),
                          onTap: getImage,
                        ),
                        isLoading
                            ? Container(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : SizedBox(),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      user.username,
                      style: TextStyle(
                          color: colorBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      user.email,
                      style: TextStyle(color: colorGrey),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: colorLightGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      user.weight == 0
                                          ? '-'
                                          : user.weight.toString() + ' kg',
                                      style: TextStyle(
                                          color: colorPrimary, fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Weight',
                                      style: TextStyle(
                                          color: colorGrey, fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              )),
                          VerticalDivider(
                            thickness: 1,
                            color: colorGrey,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      user.height == 0
                                          ? '-'
                                          : user.height.toString() + ' cm',
                                      style: TextStyle(
                                          color: colorPrimary, fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Height',
                                      style: TextStyle(
                                          color: colorGrey, fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              )),
                          VerticalDivider(
                            thickness: 1,
                            color: colorGrey,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.age == 0
                                        ? '-'
                                        : user.age.toString() + ' yrs',
                                    style: TextStyle(
                                        color: colorPrimary, fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Age',
                                    style: TextStyle(
                                        color: colorGrey, fontSize: 12),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ProfileWidget(
                            heading: 'Name', value: user.username),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child:
                            ProfileWidget(heading: 'Email', value: user.email),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ProfileWidget(
                            heading: 'Phone Number', value: user.contactNum),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ProfileWidget(
                            heading: 'Membership Number',
                            value: user.memberNumber.isEmpty
                                ? '-'
                                : user.memberNumber),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ProfileWidget(
                            heading: 'City',
                            value: user.address.city.isEmpty
                                ? '-'
                                : user.address.city),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ProfileWidget(
                            heading: 'State',
                            value: user.address.state.isEmpty
                                ? '-'
                                : user.address.state),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ProfileWidget(
                            heading: 'Starboard',
                            value:
                                user.starboard.isEmpty ? '-' : user.starboard),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ProfileWidget(
                            heading: 'Port',
                            value: user.port.isEmpty ? '-' : user.port),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ProfileWidget(
                            heading: 'Sculling',
                            value: user.sculling.isEmpty ? '-' : user.sculling),
                      ),
                    ],
                  ),
                ))
              ],
            )
          : SizedBox(),
    );
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        filesPicked = true;
        updateImage();
      } else {
        print('No image selected');
      }
    });
  }

  updateImage() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlUpdateDP + user.sId;
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
      String url = mResponse.profileImage.replaceAll('\\', '/');
      saveImage(url).then((value) {
        setState(() {
          imgUrl = url;
        });
      });
    } else {
      MySnackBar.showSnackBar(context, 'Something Went Wrong');
    }
  }

  getError(var streamedResponse) async {
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    MySnackBar.showSnackBar(context, 'Something Went Wrong');
  }
}
