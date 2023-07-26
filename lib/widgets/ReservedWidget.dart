import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/ReservedModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/Reservation/ReservedDetailView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/feedback/feedback_widget.dart';

import 'CancelWidget.dart';

class ReservedWidget extends StatelessWidget {
  final ReservedModel reserved;
  final String userId;
  final Function updated;

  ReservedWidget(
      {required this.reserved, required this.userId, required this.updated});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CachedImage(
                image:
                    ApiClient.baseUrl + reserved.equipments[0].equipmentImage,
                imageHeight: 70,
                imageWidth: 70,
                radius: 0,
                padding: 0,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reserved.equipments[0].equipmentName,
                      style: TextStyle(color: colorBlack, fontSize: 16),
                    ),
                    Text(
                      reserved.equipments[0].equipmentDescription,
                      style: TextStyle(color: colorGrey, fontSize: 12),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  InkWell(
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          color: colorSilver,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: colorDarkRed,
                          size: 12,
                        ),
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => Wrap(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: CancelWidget(
                                      reservationId: reserved.sId,
                                    ),
                                  ),
                                ],
                              )).then((value) {
                        if (value is bool && value) {
                          updated();
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: colorBlue,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: InkWell(
                        child: Icon(
                          Icons.visibility,
                          color: colorWhite,
                          size: 12,
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ReservedDetailView(reserved: reserved)));
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. of Items',
                    style: TextStyle(color: colorTextSecondary, fontSize: 12),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${reserved.quantity}",
                    style: TextStyle(color: colorBlack, fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date:',
                        style:
                            TextStyle(color: colorTextSecondary, fontSize: 12),
                      ),
                      Text(
                        getDate(),
                        style: TextStyle(color: colorBlack, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time:',
                        style:
                            TextStyle(color: colorTextSecondary, fontSize: 12),
                      ),
                      Text(
                        reserved.slots[0].slotTime,
                        style: TextStyle(color: colorBlack, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text(
                'Add Feedback',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          insetPadding: EdgeInsets.all(20),
                          content: FeedbackWidget(userID: userId,equipmentID: reserved.sId,),
                        )).then((value) {
                  if (value is bool && value) {
                    updated();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  String getDate() {
    if (reserved.slots[0].date == '') {
      return '';
    }
    DateTime date = DateTime.parse(reserved.slots[0].date);
    DateFormat format = new DateFormat('dd MMMM yyyy');
    String strDate = format.format(date);
    return strDate;
  }
}
