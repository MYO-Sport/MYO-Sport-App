import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/AthleteWidget.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';

class WorkOutDataCoachView extends StatefulWidget {
  final bool isBack;

  WorkOutDataCoachView({this.isBack = true});

  @override
  _WorkOutDataCoachViewState createState() => _WorkOutDataCoachViewState();
}

class _WorkOutDataCoachViewState extends State<WorkOutDataCoachView> {
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
          child: Padding(
            padding: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isBack
                    ? InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: colorWhite,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    : Icon(
                        Icons.arrow_back_ios,
                        color: colorWhite.withOpacity(0),
                      ),
                Text(
                  'WorkOut Data',
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0),
                ),
                Icon(
                  Icons.arrow_back_ios,
                  color: colorWhite.withOpacity(0),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            InputFieldSuffix(
              text: 'Search by name,team name...',
              suffixImage: 'assets/images/filter-icon-for-bar.png',
              onChange: (text) {},
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: GridView(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 1),
                  children: [
                    AthleteWidget(
                      name: 'Name',
                      image: '',
                      email: '',
                      id: '',
                      userId: '',
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
