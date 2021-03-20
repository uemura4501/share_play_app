import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/repositories/GroupPlayRepository.dart';
import 'package:share_play_app/screens/component/play_card.dart';
import 'package:share_play_app/screens/group/group_member_screen.dart';
import 'package:share_play_app/screens/play/new_play_screen.dart';

class GroupPlayScreen extends StatefulWidget {
  Group group;
  GroupPlayScreen({Key key, @required this.group}) : super(key: key);
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
        title: Text('${widget.group.groupName}'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new GroupMemberScreen(
                    group: widget.group,
                  ),
                ),
              ),
            },
            child: Text("メンバー"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          _navigateAndDisplayNewPlayScreen(context);
        },
        child: Icon(Icons.create),
      ),
    );
  }

  _navigateAndDisplayNewPlayScreen(BuildContext context) async {
    final checkedItems = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NewPlayScreen(group: widget.group),
      ),
    );
  }
}
