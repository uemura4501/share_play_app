import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/models/progressReport.dart';
import 'package:share_play_app/models/reply.dart';

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
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              Text('経過報告'),
            ],
          ),
          _progressRepotsRow(widget.play.progressReports),
          Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              Text('返信'),
            ],
          ),
          _repliesRow(widget.play.replies),
        ]),
      ),
    );
  }

  _progressRepotsRow(List<ProgressReport> prs) {
    return ListView.builder(
      shrinkWrap: true, //just set this property
      padding: const EdgeInsets.all(0),
      itemCount: prs.length,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 10.0),
                child: Text(prs[index].text),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(DateFormat('yyyy/MM/dd HH:mm')
                            .format(prs[index].createdAt) +
                        ' 投稿'),
                    Text(DateFormat('yyyy/MM/dd HH:mm')
                            .format(prs[index].updatedAt) +
                        ' 更新'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _repliesRow(List<Reply> replies) {
    return ListView.builder(
      shrinkWrap: true, //just set this property
      padding: const EdgeInsets.all(0),
      itemCount: replies.length,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 10.0),
                child: Text(replies[index].text),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(DateFormat('yyyy/MM/dd HH:mm')
                            .format(replies[index].createdAt) +
                        ' 投稿'),
                    Text(DateFormat('yyyy/MM/dd HH:mm')
                            .format(replies[index].updatedAt) +
                        ' 更新'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
