

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/ReservedModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class ReservedDetailView extends StatefulWidget {

  final ReservedModel reserved;

  ReservedDetailView({required this.reserved});

  @override
  _ReservedDetailViewState createState() => _ReservedDetailViewState();
}

class _ReservedDetailViewState extends State<ReservedDetailView> {
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
        title: 'Equipment Detail',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CachedImage(
                image: ApiClient.baseUrl+widget.reserved.equipments[0].equipmentImage,
                radius: 0,
                padding: 0,
                fit: BoxFit.fill,
                imageHeight: 180,
                imageWidth: 180),
          ),
          Expanded(
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: Container(
                  decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.reserved.equipments[0].equipmentName,
                        style: TextStyle(color: colorBlack, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.reserved.equipments[0].equipmentDescription,
                        style: TextStyle(color: colorGrey, fontSize: 12),
                      ),
                      Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Number of Items'),
                              Text("${widget.reserved.quantity}",style: TextStyle(color: colorPrimary,fontSize: 18),)
                            ],
                          ),
                          Divider(thickness: 0.5,color: colorSilver,),
                          SizedBox(height: 20,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date'),
                              Text(getDate(),style: TextStyle(color: colorPrimary,fontSize: 14),)
                            ],
                          ),
                          Divider(thickness: 0.5,color: colorSilver,),
                          SizedBox(height: 20,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Time Slot'),
                              Text(widget.reserved.slots[0].slotTime,style: TextStyle(color: colorPrimary,fontSize: 14),)
                            ],
                          ),
                          Divider(thickness: 0.5,color: colorSilver,),
                          SizedBox(height: 20,),

                        ],
                      )),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  String getDate(){
    if(widget.reserved.slots[0].date==''){
      return '';
    }
    DateTime date=DateTime.parse(widget.reserved.slots[0].date);
    DateFormat format=new DateFormat('dd MMMM yyyy');
    String strDate=format.format(date);
    return strDate;
  }

}
