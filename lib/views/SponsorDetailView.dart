
import 'package:flutter/material.dart';
import 'package:us_rowing/models/SponsorModel.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/ProductWidget.dart';
import 'package:us_rowing/widgets/SimpleToolbar.dart';

class SponsorDetailView extends StatefulWidget {
  final SponsorModel sponsor;

  const SponsorDetailView({required this.sponsor});

  @override
  _SponsorDetailViewState createState() => _SponsorDetailViewState();
}

class _SponsorDetailViewState extends State<SponsorDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackgroundLight,
        appBar: SimpleToolbar(title:widget.sponsor.name),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('About Us',style: TextStyle(color: colorBlack,fontSize: 16),),
                      SizedBox(height: 5,),
                      Divider(height: 0,thickness: 1,),
                      SizedBox(height: 5,),
                      Text(widget.sponsor.description,style: TextStyle(color: colorGrey,fontSize: 12),)
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Address',style: TextStyle(color: colorBlack,fontSize: 16),),
                    SizedBox(height: 5,),
                    Text(widget.sponsor.address,style: TextStyle(color: colorGrey,fontSize: 12),textAlign: TextAlign.start,)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Products',style: TextStyle(color: colorBlack,fontSize: 16),),
                      SizedBox(height: 5,),
                      Divider(height: 0,thickness: 1,),
                      SizedBox(height: 5,),
                      widget.sponsor.products.length>0?
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: widget.sponsor.products.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.66,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 10.0,
                          crossAxisCount: 2,
                        ),
                        itemBuilder:
                            (BuildContext context, int index) {
                          Products product=widget.sponsor.products[index];
                          return ProductWidget(product: product);
                        },
                      ):
                      Text('No Products Found',style: TextStyle(color: colorGrey,fontSize: 12),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
