import 'package:flutter/material.dart';
import 'package:us_rowing/widgets/ChatWidget.dart';

class MyTeamChat extends StatefulWidget {
  final String coachName;
  final String coachImage;
  MyTeamChat({this.coachName='',this.coachImage=''});
  @override
  _MyTeamChatState createState() => _MyTeamChatState();
}

class _MyTeamChatState extends State<MyTeamChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemBuilder: (context,index){
              return ChatWidget(name: 'Salena Gomez',image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Heidi_Klum_by_Glenn_Francis.jpg/1200px-Heidi_Klum_by_Glenn_Francis.jpg');
            })
    );
  }
}
