import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/repositories/CreateNewPlayRepository.dart';

class NewPlayScreen extends StatefulWidget {
  Group group;
  NewPlayScreen({Key key, @required this.group}) : super(key: key);
  @override
  _NewPlayScreenState createState() => new _NewPlayScreenState();
}

class _NewPlayScreenState extends State<NewPlayScreen> {
  Play new_play;

  @override
  void initState() {
    super.initState();
    new_play = new Play.fromJson({
      'title': '',
      'text': '',
      'requester_id': 1,
      'requester_name': '田中 栄三郎',
      'group_id': widget.group.id,
      'group_name': widget.group.groupName,
    });
  }

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
        title: Text('新しい祈りの課題'),

        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => createPlay(context),
            child: Text("投稿"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Container(
        child: Column(children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "タイトル"),
            onChanged: (value) {
              setState(() {
                new_play.title = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: "本文"),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                new_play.text = value;
              });
            },
          )
        ]),
      ),
    );
  }

  createPlay(BuildContext context) {
    CreateNewPlayRepository.createNewPlay(new_play).then((result) {
      if (result) {
        //保存成功
        Navigator.of(context).pop();
      } else {
        return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('エラー'),
            content: Text('正常に保存できませんでした。'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(0),
              ),
            ],
          ),
        );
      }
    });
  }
}
