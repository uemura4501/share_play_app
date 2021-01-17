import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/screens/component/play_card.dart';
import 'package:share_play_app/repositories/GroupPlayRepository.dart';

class GroupPlayScreen extends StatefulWidget {
  final String groupName;
  GroupPlayScreen({Key key, @required this.groupName}) : super(key: key);
  @override
  _GroupPlayScreenState createState() => new _GroupPlayScreenState();
}

class _GroupPlayScreenState extends State<GroupPlayScreen> {
  List<Play> _repositories = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 左側の戻るアイコン
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // タイトル：グループ名
        title: Text('${widget.groupName}'),
      ),
      body: Container(
        child: FutureBuilder<List<Play>>(
          future: GroupPlayRepository.getGroupPlay('aaa'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _repositories = snapshot.data;
              return PlayCard(_repositories);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
