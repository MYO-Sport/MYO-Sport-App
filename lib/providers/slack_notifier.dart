import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:us_rowing/models/slack/slack_users_model.dart';

class SlackNotifier extends ChangeNotifier {
  int progress = 0;

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setUserAgent(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.3")
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          progress = progress;
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://flutter.dev')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(
        Uri.parse('https://slack.com/intl/en-in/get-started#/createnew'));

  int get getProgress => progress;
/*   List<SlackMessagesModel> _messagesList = [];
  // List<Member> _usersList = [];
  List<SlackMessagesModel> get messageList => _messagesList; */

  // var loading = false;
  // var checkEmail = false;

  /* Future<List<Member>?> fetchUsersList() async {
    const String slackToken =
        'xoxp-5444083524757-5447059404530-5488219679908-0ed11ae477ff4c3760f725a7c2d6537f';
    // const String slackToken =
    //     'xoxb-5444083524757-5485781785122-uuychi4rhaQZF4GiC1c8VEZ3';
    const String apiUrl = 'https://slack.com/api/users.list';

    final response = await http.get(Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $slackToken'});

    switch (response.statusCode) {
      case 200:
        var data = slackUsersModelFromJson(response.body);
        return data.members;

      default:
        return null;
    }
  }

  checkEmailFunc() async {
    var list = await fetchUsersList();
    // var email = await getUserEmail();
    var email = 'usamaali185.ua@gmail.com';

    // print(list.toString());
    // list!.forEach((element) {
    //   if (element.profile.email == email) {
    //     checkEmail = true;
    //   } else {
    //     checkEmail = false;
    //   }
    // });
    checkEmail = list!.any((element) => element.profile.email == email);
    notifyListeners();
    // print(checkEmail);
  }

  void openSlackLoginPage() async {
    const String slackLoginUrl =
        'https://slack.com/intl/en-in/get-started#/createnew';

    if (await launchUrl(Uri.parse(slackLoginUrl),
        mode: LaunchMode.externalApplication)) {
      await launchUrlString(slackLoginUrl,
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $slackLoginUrl';
    }
  }

  openSlackUrl() {}

  /*  List<Channel> _channelsList = [];

  /* Future<List<Channel>?> */ getSlackMessages() async {
    // const String slackToken =
    //     'xoxp-5444083524757-5447059404530-5488219679908-0ed11ae477ff4c3760f725a7c2d6537f';
    const String slackToken =
        'xoxb-5444083524757-5485781785122-uuychi4rhaQZF4GiC1c8VEZ3';
    // final String channelID = 'YOUR_CHANNEL_ID';
    const String apiUrl =
        'https://slack.com/api/conversations.list?types=public_channel,private_channel';

    try {
      final response = await http.get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $slackToken'});
      if (response.statusCode == 200) {
        final jsonData = slackChannelsModelsFromJson(response.body);

        debugPrint(jsonData.toJson().toString());

        _channelsList = jsonData.channels;
        notifyListeners();
      } else {
        print("ERROR");
      }
    } catch (e) {}
  }

  

  void openSlackApp(String channelName) async {
    final url = 'slack://channel?team={T05D22FFEN9}&id=$channelName';
    const playStoreUrl =
        'https://play.google.com/store/apps/details?id=com.Slack';

    if (await launchUrl(Uri.parse(url))) {
      await launchUrlString(url);
    } else {
      if (await launchUrl(Uri.parse(playStoreUrl))) {
        await launchUrlString(playStoreUrl);
      } else {
        throw 'Could not launch $playStoreUrl';
      }
    }
  } */ */
}
