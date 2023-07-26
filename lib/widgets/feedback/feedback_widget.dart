import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:us_rowing/api_handler/api_handler.dart';
import '../../utils/AppColors.dart';

class FeedbackWidget extends StatefulWidget {
  final String userID;
  final String equipmentID;

  const FeedbackWidget(
      {Key? key, required this.userID, required this.equipmentID})
      : super(key: key);

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  var controller = TextEditingController();
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.sizeOf(context).height * 0.45,
      color: colorWhite,
      padding: EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text(
            'LogBook',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: colorBlack),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            child: TextField(
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              controller: controller,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Provide your feedback',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Add Rating',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          RatingBar(
              itemPadding: EdgeInsets.all(5),
              maxRating: 5,
              tapOnlyMode: true,
              ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: SizedBox(),
                  empty: Icon(
                    Icons.star,
                    color: Colors.grey,
                  )),
              onRatingUpdate: (value) {
                rating = value;
                setState(() {});
              }),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                giveFeedback();
              },
              child: Text(
                "Submit",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }

  giveFeedback() {
    Navigator.pop(context);
    ApiHandler.sendEquipmentFeedback(
        widget.userID, widget.equipmentID, controller.text, rating);
    /* 
    String apiUrl = ApiClient.urlGiveFeedback;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': userId,
      'feedback_title': txtTitle,
      'feedback_text': txtDescription,
    }).catchError((value) {
     
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
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
       
        MySnackBar.showSnackBar(context, 'Error: ' + mResponse.message);
      }
    } else {
    
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
    } */
  }
}
