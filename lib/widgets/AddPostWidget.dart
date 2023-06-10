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
import 'package:us_rowing/utils/MyMultipartRequest.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'PrimaryButton.dart';

class AddPostWidget extends StatefulWidget {
  final String id;
  final Function onAdd;
  final String type;

  AddPostWidget({required this.id, required this.onAdd, required this.type});

  @override
  _AddPostWidgetState createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  List<File> file = [];
  bool filesPicked = false;
  String fileType = postText;

  double progress = 0;

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
            SingleChildScrollView(
              child: Column(
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
                              'Create Post',
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
                                  addPost();
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorGrey),
                          color: colorWhite,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: TextField(
                            controller: contentController,
                            keyboardType: TextInputType.text,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Whats On Your Mind . . .'),
                          ),
                        ),
                        height: 200.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  filesPicked
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: fileType==postFile?colorWhite:colorBlack,
                          ),
                          child: fileType == postImg
                              ? Image.file(file[0], fit: BoxFit.cover)
                              : fileType == postFile
                                  ? Row(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/images/pdf.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 10,),
                                      Flexible(child: Text(path.basename(file[0].path),maxLines: 2,))

                                    ],
                                  )
                                  : Center(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: colorWhite,
                                      ),
                                    ),
                        )
                      : Column(
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
                                        'Upload Picture',
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
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    color: Colors.black38,
                    child: Stack(
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                              value: progress,
                              valueColor: new AlwaysStoppedAnimation<Color>(colorBlue),
                            )),

                        Center(child: Text(getProgressString(),style: TextStyle(color: colorWhite,fontSize: 10),),)
                      ],
                    )
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  String getProgressString(){
    if(progress > 0.05){
      return ((progress*100) - 5).toStringAsFixed(1)+'%';
    }else{
      return (progress*100).toStringAsFixed(1)+'%';
    }
  }

  bool validate() {
    postContent = contentController.text;
    if (postContent.isEmpty) {
      MySnackBar.showSnackBar(context, 'Enter Post Content');
      return false;
    }
    return true;
  }

  Future getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true
    );
    if (result != null) {
      setState(() {
        file = result.paths.map((path) => File(path!)).toList();
        print('added ${file.length} images');
        fileType = postImg;
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

  addPost() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = '';
    if (widget.type == typeClub) {
      apiUrl = ApiClient.urlAddClubPost;
    } else if (widget.type == typeCoach) {
      apiUrl = ApiClient.urlAddCoachPost;
    } else if (widget.type == typeTeam) {
      apiUrl = ApiClient.urlAddTeamPost;
    } else if (widget.type == typeUsFeed) {
      apiUrl = ApiClient.urlAddUSPost;
    }
    print('userId: '+userId);
    print('text: '+contentController.text);
    print('mediaType: '+fileType);
    final request = MyMultipartRequest(
      'POST',
      Uri.parse(apiUrl),
      onProgress: (int bytes, int total) {
        final progress = bytes / total;
        print('progress: $progress ($bytes/$total)');
        setState(() {
          this.progress=progress;
        });
      },
    );
    request.fields['creater_id'] = userId;
    request.fields['feed_text'] = contentController.text;
    request.fields['media_type'] = fileType;
    if (widget.type == typeClub) {
      request.fields['club_id'] = widget.id;
    } else if (widget.type == typeCoach) {
      request.fields['coach_id'] = widget.id;
    } else if (widget.type == typeTeam) {
      request.fields['team_id'] = widget.id;
    }

    if (filesPicked) {
      for (File mFile in file) {
        request.files.add(new http.MultipartFile.fromBytes(
            'media', await mFile.readAsBytes(),
            filename: path.basename(mFile.path)));
      }
    }

    /*request.files.add(new http.MultipartFile.fromBytes(
        'media', await _image.readAsBytes(),
        filename: path.basename(_image.path)));*/
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
      print('Error Exception: ' '$error');
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
