import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/screens/group/new_member_screen.dart';

class NewGroupScreen extends StatefulWidget {
  NewGroupScreen({Key key}) : super(key: key);
  @override
  _NewGroupScreenState createState() => new _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  List<Member> _repositories = new List<Member>();

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
        title: Text('新しいグループ'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new NewMemberScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
