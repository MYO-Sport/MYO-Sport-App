
import 'package:flutter/cupertino.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/ConInputField.dart';

import 'PrimaryButton.dart';

class TimePickBottom extends StatefulWidget{


  final Function onPick;

  TimePickBottom({required this.onPick});

  @override
  State<StatefulWidget> createState() => _TimePickBottomState();

}


class _TimePickBottomState extends State<TimePickBottom>{

  TextEditingController hourController=TextEditingController();
  TextEditingController mintsController=TextEditingController();
  TextEditingController secController=TextEditingController();
  TextEditingController tenthController=TextEditingController();

  String hour= '';
  String mints= '';
  String sec= '';
  String tenth= '';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,top: 10),
              child: Text('Pick Time Duration',style: TextStyle(color:colorBlack,fontSize:22)),
            ),
            SizedBox(height:30),
            Row(
              children: [
                SizedBox(width: 20,),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: ConInputField(
                        text: 'hours',
                        maxLength: 7,
                        controller: hourController,
                      ),
                    )
                ),
                SizedBox(width: 5,),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: ConInputField(
                        text: 'mints',
                        maxLength: 2,
                        controller: mintsController,
                      ),
                    )
                ),
                SizedBox(width: 5,),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: ConInputField(
                        text: 'sec',
                        maxLength: 2,
                        controller: secController,
                      ),
                    )
                ),
                SizedBox(width: 5,),
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: colorGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: ConInputField(
                        maxLength: 1,
                        text: 'Tenth',
                        controller: tenthController,
                      ),
                    )
                ),
                SizedBox(width: 20,),
              ],
            ),
            SizedBox(height:40),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceAround,
              children: [

                PrimaryButton(width: MediaQuery.of(context).size.width*.45,
                    height: 40,
                    text: 'Cancel',
                    startColor: colorGreyTrans,
                    endColor: colorGreyTrans,
                    textColor: colorBlack,
                    radius: 8,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                PrimaryButton(width: MediaQuery.of(context).size.width*.45,
                    height: 40,
                    text: 'Done',
                    startColor: colorPrimary,
                    endColor: colorPrimary,
                    radius: 8,
                    onPressed: () {
                      if(validate()){
                        widget.onPick('$hour:$mints:$sec:$tenth');
                        Navigator.of(context).pop();
                      }
                    }),
              ],),
            SizedBox(height:10),
          ],
        ),
      ),
    );
  }

  bool validate(){
    hour= hourController.text;
    mints= mintsController.text;
    sec= secController.text;
    tenth= tenthController.text;
    if(hour.isEmpty || mints.isEmpty || sec.isEmpty || tenth.isEmpty)
      return false;
    return true;
  }

}