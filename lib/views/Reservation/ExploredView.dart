import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:us_rowing/models/EqCategoryModel.dart';
import 'package:us_rowing/models/EquipmentModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/CategoriesResponse.dart';
import 'package:us_rowing/network/response/EquipmentsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/widgets/CategoryWidget.dart';
import 'package:us_rowing/widgets/EquipmentWidget.dart';
import 'package:us_rowing/widgets/InputFieldSuffix.dart';
import 'package:http/http.dart' as http;

class ExploredView extends StatefulWidget {

  final String clubId;
  final String userId;

  ExploredView({required this.clubId, required this.userId});

  @override
  State<StatefulWidget> createState() => _StateExploredView();
}

class _StateExploredView extends State<ExploredView> {


  List<EqCategoryModel> categories=[];
  List<EquipmentModel> equipments=[];
  List<EquipmentModel> showEquipments=[];
  bool gettingCategories=true;
  int selected=0;
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:
      gettingCategories?
      Center(
        child:CircularProgressIndicator() ,
      ):
      categories.length==0?
      Center(
        child: Text('No Equipments in this Club',style: TextStyle(color: colorGrey),),
      ):
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.0,
          ),
          InputFieldSuffix(
            text: 'Search equipments',
            suffixImage: 'assets/images/search.png',
            onChange: onSearch,
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context,index){
                  EqCategoryModel category=categories[index];
                  return InkWell(child: CategoryWidget(index: index,last: categories.length-1,category: category,selected: selected,),onTap: (){
                    setState(() {
                      selected=index;
                    });
                    getEquipments(category.sId);
                  },);
                }),
          ),

          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 5),
            child: Text(
              'Available Equipments',
              style: TextStyle(
                  color: colorBlack, fontSize: 16.0, letterSpacing: 0.5),
            ),
          ),
          Expanded(child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child:
            isLoading?
            Center(child: CircularProgressIndicator(),):
            showEquipments.length==0?
            Center(child: Text('No Equipments Found',style: TextStyle(color: colorGrey),)):
            GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: showEquipments.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.66,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10.0,
                crossAxisCount: 2,
              ),
              itemBuilder:
                  (BuildContext context, int index) {
                EquipmentModel equipment=showEquipments[index];
                return EquipmentWidget(equipment: equipment,userId: widget.userId,clubId: widget.clubId,);
              },
            ),
          ))
        ],
      ),
    );
  }

  onSearch(String text) {
    if(text.isNotEmpty){
      showEquipments.clear();
      for(EquipmentModel club in equipments){
        if(club.equipmentName.toLowerCase().contains(text.toLowerCase())){
          showEquipments.add(club);
        }
      }
      setState(() {});
    }else{
      showEquipments.clear();
      setState(() {
        showEquipments.addAll(equipments);
      });
    }
  }

  getCategories() async {
    String apiUrl = ApiClient.urlGetCategories;

    print('Url: '+apiUrl);
    print('Club Id: '+ widget.clubId);

    final response = await http
        .post(Uri.parse(apiUrl),
        body: {
          'club_id': widget.clubId
        })
        .catchError((value) {
      setState(() {
        gettingCategories = false;
      });
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      CategoriesResponse mResponse =
      CategoriesResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          categories=mResponse.categories;
          gettingCategories=false;
        });
        if(mResponse.categories.length!=0){
          getEquipments(mResponse.categories.first.sId);
        }
      } else {
        setState(() {
          gettingCategories = false;
        });
        MySnackBar.showSnackBar(context,mResponse.message);
      }
    } else {
      setState(() {
        gettingCategories=false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context,'Check Your Internet Connection');
    }
  }

  getEquipments(String catId) async {

    showEquipments.clear();
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlGetEquipments;

    print('Url: '+apiUrl);
    print('Club Id: '+ widget.clubId);
    print('CategoryId Id: '+ widget.clubId);

    final response = await http
        .post(Uri.parse(apiUrl),
        body: {
          'club_id': widget.clubId,
          'category_id': catId
        })
        .catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(context,  'Error: ' + 'Check Your Internet Connection');
      return value;

    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      EquipmentsResponse mResponse =
      EquipmentsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          isLoading=false;
          equipments=mResponse.equipments;
          showEquipments.addAll(equipments);
        });
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context,mResponse.message);
      }
    } else {
      setState(() {
        isLoading=false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context,'Check Your Internet Connection');
    }
  }
}
