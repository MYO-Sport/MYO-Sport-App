
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:us_rowing/widgets/SecondaryButton.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class CompleteView extends StatefulWidget {
  @override
  _CompleteViewState createState() => _CompleteViewState();
}

class _CompleteViewState extends State<CompleteView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      resizeToAvoidBottomInset: false,
      appBar: SimpleToolbar(
        title: 'Booking Completed',
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imgComplete,width: 90,height: 90,),
            SizedBox(height: 20,),
            Text('Booking Completed',style: TextStyle(color: colorBlack,fontSize: 20),),
            SizedBox(height: 5,),
            Text('You Booking is Successfully Completed',style: TextStyle(color: colorGrey,fontSize: 12),),
            SizedBox(height: 40,),
            PrimaryButton(text: 'View Booking', onPressed: (){ Navigator.of(context).pop();},endColor: colorPrimary,startColor: colorPrimary,height: 40,),
            SizedBox(height: 10,),
            SecondaryButton(text: 'Back to Explore', onPressed: (){Navigator.of(context).pop();},height: 40,)

          ],
        ),
      ),
    );
  }
}
