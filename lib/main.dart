import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:us_rowing/models/UserModel.dart';
import 'package:us_rowing/providers/channel_notifier.dart';
import 'package:us_rowing/providers/channels_video_notifier.dart';
import 'package:us_rowing/providers/club_providers/club_provider.dart';
import 'package:us_rowing/providers/slack_notifier.dart';
import 'package:us_rowing/shared_prefs/shared_prefs.dart';
import 'package:us_rowing/utils/AppColors.dart';
import 'package:us_rowing/utils/AppConstants.dart';
// import 'package:us_rowing/utils/AppConstants.dart';
import 'package:us_rowing/views/AthleteView/HomeView.dart';
import 'package:us_rowing/views/CoachView/CoachHomeView.dart';
import 'package:us_rowing/views/WelComeView.dart';
// import 'package:us_rowing/views/AthleteView/HomeView.dart';
// import 'package:us_rowing/views/CoachView/CoachHomeView.dart';
// import 'package:us_rowing/views/WelComeView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await FlutterDownloader.initialize(debug: true);
  bool login = await SharedPrefs.isLogin();
  UserModel userModel = await SharedPrefs.getUser();
  String userType = userModel.type;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp(
    login: login,
    userType: userType,
    userModel: userModel,
  ));
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) =>MyApp(login: login,userType: userType,userModel: userModel,), // Wrap your app
  // ),);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool login;
  final String userType;
  final UserModel userModel;

  MyApp({required this.login, required this.userType, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SlackNotifier>(
          create: (_) => SlackNotifier(),
        ),
        ChangeNotifierProvider<ChannelNotifier>(
          create: (_) => ChannelNotifier(),
        ),
        ChangeNotifierProvider<ChannelsVideoNotifier>(
          create: (_) => ChannelsVideoNotifier(),
        ),
        ChangeNotifierProvider<ClubProvider>(
          create: (_) => ClubProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MyoSport',
        debugShowCheckedModeBanner: false,
        //locale: DevicePreview.locale(context), // Add the locale here
        //builder: DevicePreview.appBuilder,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: mColorSwatch,
          primaryColor: colorPrimary,

          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,

          fontFamily: 'Circular',
        ),
        home: login && userType == typeAthlete
            ? HomeView(userModel: userModel)
            : login
                ? CoachHomeView(userModel: userModel)
                : WelcomeView(),
      ),
    );
  }
}
