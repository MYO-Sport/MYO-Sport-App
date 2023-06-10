import 'package:flutter/material.dart';
import 'package:us_rowing/widgets/ChatWidget.dart';

class UsFeedChat extends StatefulWidget {
  final String coachName;
  final String coachImage;
  UsFeedChat({this.coachName='',this.coachImage=''});
  @override
  _UsFeedChatState createState() => _UsFeedChatState();
}

class _UsFeedChatState extends State<UsFeedChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemBuilder: (context,index){
              return ChatWidget(name: 'HEIDI KLUM',image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Heidi_Klum_by_Glenn_Francis.jpg/1200px-Heidi_Klum_by_Glenn_Francis.jpg');
            })
    );
  }
}
