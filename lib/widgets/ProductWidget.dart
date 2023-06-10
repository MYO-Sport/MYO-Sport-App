import 'package:flutter/material.dart';
import 'package:us_rowing/models/SponsorModel.dart';
import 'package:us_rowing/network/ApiClient.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/widgets/CachedImage.dart';

class ProductWidget extends StatelessWidget {
  final Products product;

  ProductWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: CachedImage(
                      image: ApiClient.baseUrl + product.productImage,
                      radius: 2,
                      padding: 0,
                      fit: BoxFit.fill,
                      imageHeight: MediaQuery.of(context).size.height,
                      imageWidth: MediaQuery.of(context).size.width)),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    product.name,
                    style: TextStyle(color: colorBlack, fontSize: 10),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Flexible(
                      child: Text(
                    '\$10',
                    style: TextStyle(color: colorDarkRed, fontSize: 10),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: colorPrimary, borderRadius: BorderRadius.circular(8.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_basket,
                      color: colorWhite,
                      size: 12,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Buy Now',
                      style: TextStyle(color: colorWhite, fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                  color: colorPrimary, borderRadius: BorderRadius.circular(11)
              ),
              child: Icon(Icons.shopping_cart,color: colorWhite,size: 12,),
            ),
        )
      ],
    );
  }
}
