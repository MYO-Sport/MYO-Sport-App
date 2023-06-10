import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/EventInputField.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class FeedbackView extends StatefulWidget {

  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {

  bool isLoading=false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  String txtTitle='',userId='', txtDescription='';

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
  Widget build(BuildContext context)  {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: colorBackgroundLight,
            appBar: SimpleToolbar(title: 'Feedback',),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: EventInputField(
                      type: TextInputType.name,
                      text: 'Title Name',
                      controller: titleController,
                      maxLength: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: EventInputField(
                      type: TextInputType.multiline,
                      text: 'Enter Description Here',
                      controller: descriptionController,
                      maxLength: 100,
                      maxLines: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: PrimaryButton(
                        startColor: colorPrimary,
                        endColor: colorPrimary,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        text: 'Submit', onPressed: () {
                      if(validate()){
                        giveFeedback();
                      }
                    }),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            )),
        isLoading?
        SafeArea(child: Center(child: CircularProgressIndicator(),)):
        SizedBox()
      ],
    );
  }

  bool validate(){
    txtTitle=titleController.text;
    txtDescription= descriptionController.text;

    if(txtTitle.isEmpty){
      MySnackBar.showSnackBar(context, 'Title is Required');
      return false;
    }

    if(txtDescription.isEmpty){
      MySnackBar.showSnackBar(context, 'Description is Required');
      return false;
    }

    return true;
  }

  giveFeedback() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGiveFeedback;

    final response = await http
        .post(
        Uri.parse(apiUrl),
        body: {
          'user_id':userId,
          'feedback_title':txtTitle,
          'feedback_text':txtDescription,
        }
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
      GeneralStatusResponse mResponse =
      GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        showToast(mResponse.message);
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context, 'Error: ' + 'Check Your Internet Connection');
    }
  }
}
