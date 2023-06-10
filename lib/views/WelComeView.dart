
import 'package:flutter/material.dart';
import 'package:us_rowing/utils/AppAssets.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/views/LoginView.dart';
import 'package:us_rowing/widgets/PrimaryButton.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    String type = '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(autoPlay: true,height: MediaQuery.of(context).size.height*0.7,viewportFraction: 1),
                items: welcomeImage.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: colorBlack
                          ),
                          child: Image.asset(image,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,)
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [colorWhite.withOpacity(0),colorWelcome,colorWelcome,colorWelcome,colorWelcome]
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0),
                              ),
                              color: Colors.transparent,
                            ),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 24),
                            child: Text(
                              txtWelcome,
                              style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 16.0,
                                  letterSpacing: 1.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                            child: PrimaryButton(
                                width: MediaQuery.of(context).size.width,
                                startColor: colorWhite.withOpacity(0.15),
                                endColor: colorWhite.withOpacity(0.15),
                              height: 48,
                                radius: 8,
                                text: 'Are you an Athlete', onPressed: (){
                              type = typeAthlete;
                              print('Athlete Clicked');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView(
                                      type: type,
                                    )),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                            child: PrimaryButton(
                              height: 48,
                                radius: 8,
                                width: MediaQuery.of(context).size.width,
                                startColor: colorWhite.withOpacity(0.15),
                                endColor: colorWhite.withOpacity(0.15),
                                text: 'Are you a Coach', onPressed: (){
                              type = typeCoach;
                              print('Coach Clicked');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView(
                                      type: type,
                                    )),
                              );
                            }),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
