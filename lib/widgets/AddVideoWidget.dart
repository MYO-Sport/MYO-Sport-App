import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/VideoPalyerItems.dart';
import 'package:us_rowing/widgets/DocumentItem.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'PrimaryButton.dart';

class AddVideoWidget extends StatefulWidget {
  final String id;
  final Function onAdd;
  final String type;
  final String stat;
  final bool isPdf;

  AddVideoWidget({required this.id, required this.onAdd, required this.type,required this.stat,this.isPdf=true});

  @override
  _AddVideoWidgetState createState() => _AddVideoWidgetState();
}

class _AddVideoWidgetState extends State<AddVideoWidget> {
  late List<File> file=[];
  bool filesPicked = false;
  String fileType = postText;

  bool videoPicker = false;
  String postContent = '';
  TextEditingController contentController = TextEditingController();
  final picker = ImagePicker();

  late String userId;
  String postType = postImg;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser().then((value) {
      setState(() {
        userId = value.sId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Material(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: colorGrey),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_ios)),
                          Text(
                            'Add Media',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                letterSpacing: 1.0),
                          ),
                          PrimaryButton(
                            text: 'Post',
                            width: 70.0,
                            height: 35.0,
                            radius: 10.0,
                            onPressed: () {
                              hideKeyboard(context);
                              if (validate()) {
                                if(fileType==postFile){
                                  addPdf();
                                }else{
                                  addVideo();
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child:
                filesPicked && fileType==postVideo?
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: colorBlack,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: VideoPlayerItems(
                      videoPlayerController: VideoPlayerController.file(
                        file[0],
                      ),
                      looping: false,
                      autoplay: false,
                    ),
                  ),
                ):
                filesPicked && fileType==postImg?
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: colorBlack,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(file[0]),
                  ),
                ):
                    filesPicked?
                        DocumentItem(mediaUrl: file[0].path,downloadAble: false,userId: '',mediaId: '',):
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorGrey),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                    'assets/images/image.png'),
                                width: 30.0,
                                height: 30.0,
                              ),
                              Text(
                                'Upload Image',
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Icon(
                                Icons.send,
                                color: colorGrey,
                              ),
                            ],
                          ),
                          onTap: () {
                            getImage();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorGrey),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                    'assets/images/video.png'),
                                width: 30.0,
                                height: 30.0,
                              ),
                              Text(
                                'Upload Video',
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Icon(
                                Icons.send,
                                color: colorGrey,
                              ),
                            ],
                          ),
                          onTap: () {
                            getVideo();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    widget.isPdf?
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorGrey),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                    'assets/images/pdf.png'),
                                width: 30.0,
                                height: 30.0,
                              ),
                              Text(
                                'Upload PDF',
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Icon(
                                Icons.send,
                                color: colorGrey,
                              ),
                            ],
                          ),
                          onTap: () {
                            getPdf();
                          },
                        ),
                      ),
                    ):
                    SizedBox(),
                  ],
                )
                )
              ],
            ),
            isLoading
                ? Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.black38,
              child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(colorBlue),
                  )),
            )
                : Container()
          ],
        ),
      ),
    );
  }

  bool validate() {
    postContent = contentController.text;
    if (!filesPicked) {
      MySnackBar.showSnackBar(context, 'Please Select the Video');
      return false;
    }
    return true;
  }

  Future getPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        file = result.paths.map((path) => File(path!)).toList();
        fileType = postFile;
        filesPicked = true;
      });
    } else {
      // User canceled the picker
    }
  }



  Future getVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        file.add(File(pickedFile.path));
        fileType = postVideo;
        filesPicked = true;
      });
    } else {
      print('No video selected');
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        file.add(File(pickedFile.path));
        fileType = postImg;
        filesPicked = true;
      });
    } else {
      print('No video selected');
    }
  }

  addVideo() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = '';
    if (widget.type == typeClub) {
      apiUrl = ApiClient.urlAddClubVideo;
    } else if (widget.type == typeCoach) {
      apiUrl = ApiClient.urlAddCoachVideo;
    } else if (widget.type == typeTeam) {
      apiUrl = ApiClient.urlAddTeamVideo;
    } else if(widget.type == typeUsFeed){
      apiUrl = ApiClient.urlAddUsVideo;
    }
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl));
    request.fields['user_id'] = userId;
    request.fields['media_type'] = fileType;
    if (widget.type == typeClub) {
      request.fields['club_id'] = widget.id;
    } else if (widget.type == typeCoach) {
      request.fields['coach_id'] = widget.id;
    } else if (widget.type == typeTeam) {
      request.fields['team_id'] = widget.id;
    }

    request.files.add(new http.MultipartFile.fromBytes(
        'media', await file[0].readAsBytes(),
        filename: path.basename(file[0].path)));

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
      showToast('Check Your Internet Connection');
    });
  }

  addPdf() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlAddPdf;
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl));
    request.fields['status'] = widget.stat;
    request.fields['creater_id']= userId;
    if (widget.type == typeClub) {
      request.fields['club_id'] = widget.id;
    } else if (widget.type == typeCoach) {
      request.fields['coach_id'] = widget.id;
    } else if (widget.type == typeTeam) {
      request.fields['team_id'] = widget.id;
    }

    request.files.add(new http.MultipartFile.fromBytes(
        'media', await file[0].readAsBytes(),
        filename: path.basename(file[0].path)));

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
      showToast('Check Your Internet Connection');
    });
  }

  getResponse(var streamedResponse) async {
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    GeneralStatusResponse mResponse =
    GeneralStatusResponse.fromJson(json.decode(response.body));
    if (mResponse.status) {
      widget.onAdd();
      Navigator.of(context).pop();
    } else {
      showToast('Check Your Internet Connection');
    }
  }

  getError(var streamedResponse) async {
    var response = await http.Response.fromStream(streamedResponse);
    print(response.body);
    showToast('Check Your Internet Connection');
  }
}
