import 'package:flutter/material.dart';
import 'package:us_rowing/models/EquipmentModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/views/Reservation/EquipmentDetailView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';

class EquipmentWidget extends StatelessWidget {

  final EquipmentModel equipment;
  final String clubId;
  final String userId;

  EquipmentWidget({required this.equipment, required this.clubId, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CachedImage(
                image: ApiClient.baseUrl+equipment.equipmentImage,
                radius: 2,
                padding: 0,
                fit: BoxFit.fill,
                imageHeight: 120,
                imageWidth: 120),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  equipment.equipmentName,
                  style: TextStyle(color: colorBlack, fontSize: 12),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2,),
                Expanded(child: Text(equipment.equipmentDescription,style: TextStyle(color: colorGrey,fontSize: 10,),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                SizedBox(height: 2,),
                PrimaryButton(
                  startColor: colorPrimary,
                    endColor: colorPrimary,
                    fontSize: 10,
                    radius: 4,
                    height: 30,
                    text: 'View Detail', onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EquipmentDetailView(equipment: equipment,clubId: clubId,userId: userId,)));

                })
              ],
            ),
          ))
        ],
      ),
    );
  }
}
