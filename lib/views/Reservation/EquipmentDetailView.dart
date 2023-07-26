import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:us_rowing/models/EquipmentModel.dart';
import 'package:us_rowing/models/SlotModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/network/response/GeneralStatusResponse.dart';
import 'package:us_rowing/network/response/QuantityResponse.dart';
import 'package:us_rowing/network/response/SlotsResponse.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppUtils.dart';
import 'package:us_rowing/utils/MySnackBar.dart';
import 'package:us_rowing/views/Reservation/CompleteView.dart';
import 'package:us_rowing/widgets/CachedImage.dart';
import 'package:http/http.dart' as http;
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';
import 'package:us_rowing/widgets/SlotWidget.dart';

class EquipmentDetailView extends StatefulWidget {
  final String clubId;
  final String userId;
  final EquipmentModel equipment;

  EquipmentDetailView(
      {required this.equipment, required this.clubId, required this.userId});

  @override
  _EquipmentDetailViewState createState() => _EquipmentDetailViewState();
}

class _EquipmentDetailViewState extends State<EquipmentDetailView> {
  bool gettingSlots = true;
  List<SlotModel> slots = [];
  late DateTime now;
  late DateTime selectedDate;
  late DateTime startDate, endDate;
  String strDate = '', strStartDate = '', strEndDate = '';
  var formatter = new DateFormat('dd MMMM yyyy');
  var formatter1 = new DateFormat('yyyy-mm-dd');
  int selected = -1;
  int availableQuantity = 0;
  int quantity = 0;
  int selectedType = 0;
  bool isLoading = false;

  DateTimeRange? picked;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    selectedDate = now;
    startDate = now;
    endDate = now.add(Duration(days: 10));
    strDate = formatter.format(now);
    strStartDate = formatter.format(startDate);
    strEndDate = formatter.format(endDate);
    getSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      resizeToAvoidBottomInset: false,
      appBar: SimpleToolbar(
        title: 'Equipment Detail',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CachedImage(
                      image:
                          ApiClient.baseUrl + widget.equipment.equipmentImage,
                      radius: 0,
                      padding: 0,
                      fit: BoxFit.fill,
                      imageHeight: 180,
                      imageWidth: 180),
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
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
                          widget.equipment.equipmentName,
                          style: TextStyle(color: colorBlack, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.equipment.equipmentDescription,
                          style: TextStyle(color: colorGrey, fontSize: 12),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: selectedType,
                                    groupValue: 0,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType = 0;
                                      });
                                      getSlots();
                                    }),
                                Text('By Time')
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: selectedType,
                                    groupValue: 1,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType = 1;
                                      });
                                      getQuantity();
                                    }),
                                Text('By Day')
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: selectedType,
                                    groupValue: 2,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedType = 2;
                                      });
                                      getRangeQuantity();
                                    }),
                                Text('By Days')
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        selectedType == 0
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  selected == -1
                                      ? Text(
                                          'Select a time slot by date.',
                                          style: TextStyle(
                                              color: colorBlack, fontSize: 16),
                                        )
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Number of Items'),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      child: Container(
                                                        height: 24,
                                                        width: 24,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorSilver,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '-',
                                                            style: TextStyle(
                                                                color:
                                                                    colorGrey,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: decreement,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                        height: 30,
                                                        width: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              '$quantity',
                                                              style: TextStyle(
                                                                  color:
                                                                      colorPrimary,
                                                                  fontSize: 18),
                                                            ),
                                                            Text(
                                                              '/$availableQuantity',
                                                              style: TextStyle(
                                                                  color:
                                                                      colorGrey,
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                        child: Container(
                                                          height: 24,
                                                          width: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: colorSilver,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: colorGrey,
                                                              size: 12,
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: increment),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Divider(
                                              thickness: 0.5,
                                              color: colorSilver,
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date'),
                                      Row(
                                        children: [
                                          Text(
                                            strDate,
                                            style: TextStyle(
                                                color: colorPrimary,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            child: Icon(Icons.arrow_drop_down,
                                                color: colorGrey),
                                            onTap: () async {
                                              DateTime? date = DateTime(1900);
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());

                                              date = (await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate,
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2100)));
                                              if (date != null) {
                                                setState(() {
                                                  selectedDate = date!;
                                                  strDate = formatter
                                                      .format(selectedDate);
                                                  selected = -1;
                                                  gettingSlots = true;
                                                });
                                                getSlots();
                                              }
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: colorSilver,
                                  ),
                                  gettingSlots
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ))
                                      : slots.length == 0
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Center(
                                                child: Text(
                                                  'No Time Slots Found at this date',
                                                  style: TextStyle(
                                                      color: colorGrey,
                                                      fontSize: 12),
                                                ),
                                              ))
                                          : GridView.builder(
                                              padding: EdgeInsets.all(10),
                                              shrinkWrap: true,
                                              primary: false,
                                              itemCount: slots.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 4.0,
                                                mainAxisSpacing: 10.0,
                                                crossAxisSpacing: 10.0,
                                                crossAxisCount: 2,
                                              ),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                SlotModel slot = slots[index];
                                                return InkWell(
                                                  child: SlotWidget(
                                                    slot: slot,
                                                    index: index,
                                                    selected: selected,
                                                  ),
                                                  onTap: () {
                                                    if (slot.status == '0') {
                                                      setState(() {
                                                        availableQuantity = slot
                                                            .availableQuantity;
                                                        quantity = 0;
                                                        selected = index;
                                                      });
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            : selectedType == 1
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Date'),
                                          Row(
                                            children: [
                                              Text(
                                                strDate,
                                                style: TextStyle(
                                                    color: colorPrimary,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: colorGrey),
                                                onTap: () async {
                                                  DateTime? date =
                                                      DateTime(1900);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());

                                                  date = (await showDatePicker(
                                                      context: context,
                                                      initialDate: selectedDate,
                                                      firstDate: DateTime.now(),
                                                      lastDate:
                                                          DateTime(2100)));
                                                  if (date != null) {
                                                    setState(() {
                                                      selectedDate = date!;
                                                      strDate = formatter
                                                          .format(selectedDate);
                                                      selected = -1;
                                                      gettingSlots = true;
                                                    });
                                                    getQuantity();
                                                  }
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: colorSilver,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Number of Items'),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      height: 24,
                                                      width: 24,
                                                      decoration: BoxDecoration(
                                                        color: colorSilver,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                              color: colorGrey,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: decreement,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '$quantity',
                                                            style: TextStyle(
                                                                color:
                                                                    colorPrimary,
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            '/$availableQuantity',
                                                            style: TextStyle(
                                                                color:
                                                                    colorGrey,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                      child: Container(
                                                        height: 24,
                                                        width: 24,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorSilver,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: colorGrey,
                                                            size: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: increment),
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: colorSilver,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Date'),
                                          Row(
                                            children: [
                                              Text(
                                                strStartDate + '-' + strEndDate,
                                                style: TextStyle(
                                                    color: colorPrimary,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                child: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: colorGrey),
                                                onTap: () async {
                                                  // DateTime? date = DateTime(1900);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());

                                                  picked =
                                                      await showDateRangePicker(
                                                    context: context,
                                                    firstDate: now,
                                                    lastDate: new DateTime(
                                                        DateTime.now().year +
                                                            10),
                                                  );
                                                  if (picked != null) {
                                                    setState(
                                                      () {
                                                        startDate =
                                                            picked!.start;
                                                        endDate = picked!.end;
                                                        strStartDate = formatter
                                                            .format(startDate);
                                                        strEndDate = formatter
                                                            .format(endDate);
                                                        // strDate =
                                                        //     formatter.format(startDate) +
                                                        //         '-' +
                                                        //         formatter.format(endDate);
                                                        isLoading = true;
                                                      },
                                                    );
                                                    getRangeQuantity();
                                                  }
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: colorSilver,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Number of Items'),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    child: Container(
                                                      height: 24,
                                                      width: 24,
                                                      decoration: BoxDecoration(
                                                        color: colorSilver,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                              color: colorGrey,
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: decreement,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '$quantity',
                                                            style: TextStyle(
                                                                color:
                                                                    colorPrimary,
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            '/$availableQuantity',
                                                            style: TextStyle(
                                                                color:
                                                                    colorGrey,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                      child: Container(
                                                        height: 24,
                                                        width: 24,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: colorSilver,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: colorGrey,
                                                            size: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: increment),
                                                ],
                                              )
                                            ],
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: colorSilver,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                        SizedBox(
                          height: 20,
                        ),
                        PrimaryButton(
                            startColor: colorPrimary,
                            endColor: colorPrimary,
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            text: 'Book Now',
                            onPressed: () {
                              if (selectedType == 0) {
                                if (selected == -1) {
                                  showToast('Please Select a slot');
                                } else if (quantity == 0) {
                                  showToast('Please select quantity of items');
                                } else {
                                  reserveSlot();
                                }
                              } else if (selectedType == 1) {
                                if (quantity == 0) {
                                  showToast('Please select quantity of items.');
                                } else {
                                  reserveDate();
                                }
                              } else {
                                if (quantity == 0) {
                                  showToast('Please select quantity of items.');
                                } else {
                                  reserveDateRange();
                                }
                              }
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.black38,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  getSlots() async {
    setState(() {
      gettingSlots = true;
    });
    slots.clear();
    String apiUrl = ApiClient.urlGetTimeSlots;

    String mDate =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';

    print('Url: ' + apiUrl);
    print('Club Id: ' + widget.userId);
    print('Equipment Id: ' + widget.equipment.sId);
    print('Date: ' + mDate);

    final response = await http.post(Uri.parse(apiUrl), body: {
      'club_id': widget.clubId,
      'equipment_id': widget.equipment.sId,
      'date': mDate,
    }).catchError((value) {
      setState(() {
        quantity = 0;
        availableQuantity = 0;
        gettingSlots = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      SlotsResponse mResponse =
          SlotsResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          quantity = 0;
          availableQuantity = 0;
          slots = mResponse.slots;
          gettingSlots = false;
        });
        // showToast('${slots.length} slots');
      } else {
        setState(() {
          quantity = 0;
          availableQuantity = 0;
          gettingSlots = false;
        });
        MySnackBar.showSnackBar(context, mResponse.message);
      }
    } else {
      setState(() {
        quantity = 0;
        availableQuantity = 0;
        gettingSlots = false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
    }
  }

  getQuantity() async {
    setState(() {
      isLoading = true;
    });

    slots.clear();
    String apiUrl = ApiClient.urlGetQuantity;

    String mDate =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';

    print('Url: ' + apiUrl);
    print('Club Id: ' + widget.userId);
    print('Equipment Id: ' + widget.equipment.sId);
    print('Date: ' + mDate);

    final response = await http.post(Uri.parse(apiUrl), body: {
      'club_id': widget.clubId,
      'equipment_id': widget.equipment.sId,
      'date': mDate,
    }).catchError((value) {
      setState(() {
        quantity = 0;
        availableQuantity = 0;
        gettingSlots = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      QuantityResponse mResponse =
          QuantityResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          quantity = 0;
          availableQuantity = mResponse.availableQuantity;
          isLoading = false;
        });
        // showToast('${slots.length} slots');
      } else {
        setState(() {
          quantity = 0;
          availableQuantity = 0;
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, mResponse.message);
      }
    } else {
      setState(() {
        quantity = 0;
        availableQuantity = 0;
        gettingSlots = false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
    }
  }

  getRangeQuantity() async {
    setState(() {
      isLoading = true;
    });

    slots.clear();
    String apiUrl = ApiClient.urlGetQuantityRange;

    String mStartDate = '${startDate.year}-${startDate.month}-${startDate.day}';
    String mEndDate = '${endDate.year}-${endDate.month}-${endDate.day}';

    print('Url: ' + apiUrl);
    print('Club Id: ' + widget.userId);
    print('Equipment Id: ' + widget.equipment.sId);
    print('Start Date: ' + mStartDate);
    print('End Date: ' + mEndDate);

    final response = await http.post(Uri.parse(apiUrl), body: {
      'club_id': widget.clubId,
      'equipment_id': widget.equipment.sId,
      'start_date': mStartDate,
      'end_date': mEndDate,
    }).catchError((value) {
      setState(() {
        quantity = 0;
        availableQuantity = 0;
        gettingSlots = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      QuantityResponse mResponse =
          QuantityResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        setState(() {
          quantity = 0;
          availableQuantity = mResponse.availableQuantity;
          isLoading = false;
        });
        // showToast('${slots.length} slots');
      } else {
        setState(() {
          quantity = 0;
          availableQuantity = 0;
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, mResponse.message);
      }
    } else {
      setState(() {
        quantity = 0;
        availableQuantity = 0;
        gettingSlots = false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
    }
  }

  reserveSlot() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlReserveSlot;

    print('Url: ' + apiUrl);
    print('User Id: ' + widget.userId);
    print('Slot Id: ' + slots[selected].sId);

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'slot_id': slots[selected].sId,
      'quantity': '$quantity'
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CompleteView()));
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.body);
      // MySnackBar.showSnackBar(context,'Check Your Internet Connection');
      Fluttertoast.showToast(msg: 'Check Your Internet Connection');
    }
  }

  reserveDate() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlReserveDate;

    String mDate =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';

    print('Url: ' + apiUrl);
    print('User Id: ' + widget.userId);
    print('Date: ' + mDate);
    print('Quantity: $quantity');

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'quantity': '$quantity',
      'date': mDate,
      'club_id': widget.clubId,
      'equipment_id': widget.equipment.sId
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CompleteView()));
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
    }
  }

  reserveDateRange() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = ApiClient.urlReserveDateRange;

    String mStartDate = '${startDate.year}-${startDate.month}-${startDate.day}';
    String mEndDate = '${endDate.year}-${endDate.month}-${endDate.day}';

    print('Url: ' + apiUrl);
    print('User Id: ' + widget.userId);
    print('StartDate: ' + mStartDate);
    print('EndDate: ' + mEndDate);
    print('Quantity: $quantity');

    final response = await http.post(Uri.parse(apiUrl), body: {
      'user_id': widget.userId,
      'quantity': '$quantity',
      'start_date': mStartDate,
      'end_date': mEndDate,
      'club_id': widget.clubId,
      'equipment_id': widget.equipment.sId
    }).catchError((value) {
      setState(() {
        isLoading = false;
      });
      MySnackBar.showSnackBar(
          context, 'Error: ' + 'Check Your Internet Connection');
      return value;
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(response.body);
      GeneralStatusResponse mResponse =
          GeneralStatusResponse.fromJson(json.decode(responseString));
      if (mResponse.status) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => CompleteView()));
      } else {
        setState(() {
          isLoading = false;
        });
        MySnackBar.showSnackBar(context, mResponse.message);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.body);
      MySnackBar.showSnackBar(context, 'Check Your Internet Connection');
    }
  }

  increment() {
    if (quantity < availableQuantity) {
      setState(() {
        ++quantity;
      });
    }
  }

  decreement() {
    if (quantity > 0) {
      setState(() {
        --quantity;
      });
    }
  }
}
