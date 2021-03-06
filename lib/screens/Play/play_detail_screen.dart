import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_play_app/models/models.dart';

class PlayDetailScreen extends StatefulWidget {
  Play play;
  PlayDetailScreen({Key key, @required this.play}) : super(key: key);
  @override
  _PlayDetailScreenState createState() => new _PlayDetailScreenState();
}

class _PlayDetailScreenState extends State<PlayDetailScreen> {
  @override
  void initState() {
    super.initState();
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
        // 祈りのタイトル
        title: Text('${widget.play.title}'),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Text('${widget.play.text}'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                  DateFormat('yyyy/MM/dd HH:mm').format(widget.play.createdAt) +
                      ' 投稿'),
              Text(
                  DateFormat('yyyy/MM/dd HH:mm').format(widget.play.updatedAt) +
                      ' 更新'),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              Text('グループ'),
              Text('${widget.play.groupName}'),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              Text('フォロー'),
              Text('${widget.play.followNum}人'),
            ],
          ),
        ]),
      ),
    );
  }
}
