import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/PrimaryButton.dart';

class CancelWidget extends StatefulWidget {
  final String reservationId;

  CancelWidget({
    required this.reservationId,
  });

  @override
  _CancelWidgetState createState() => _CancelWidgetState();
}

class _CancelWidgetState extends State<CancelWidget> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    constraints: BoxConstraints(maxHeight: 70, maxWidth: 70),
                    decoration: BoxDecoration(
                        color: colorSilver,
                        borderRadius: BorderRadius.circular(35)),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        color: colorDarkRed,
                        size: 34,
                      ),
                    ),
                  ),
                  Text(
                    'Do you want to cancel the booking.',
                    style: TextStyle(color: colorTextSecondary, fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PrimaryButton(
                          startColor: colorSilver,
                          endColor: colorSilver,
                          width: 150,
                          height: 40,
                          fontSize: 18,
                          textColor: colorBlack,
                          text: 'No',
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      PrimaryButton(
                          startColor: colorPrimary,
                          endColor: colorPrimary,
                          width: 150,
                          height: 40,
                          fontSize: 18,
                          textColor: colorWhite,
                          text: 'Yes',
                          onPressed: () {
                            cancel();
                          })
                    ],
                  )
                ],
              ),
            ),
            isLoading
                ? Container(
                    color: colorBlack.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  cancel() async {
    setState(() {
      isLoading = true;
    });

    print('ReservationId' + widget.reservationId);
    String apiUrl = ApiClient.urlCancelReservation;

    final response = await http.post(Uri.parse(apiUrl), body: {
      'reservation_id': widget.reservationId,
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      print('Error: ' + 'Check Your Internet Connection');
      return value;
    });
    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error: ' + mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('Error: ' + 'Check Your Internet Connection');
    }
  }
}
