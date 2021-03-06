import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_play_app/models/play.dart';
import 'package:share_play_app/screens/Play/play_detail_screen.dart';

class PlayCard extends StatefulWidget {
  final List<Play> _repositories;

  const PlayCard(this._repositories);

  @override
  _PlayCardState createState() => _PlayCardState();
}

class _PlayCardState extends State<PlayCard> {
  Widget build(BuildContext context) {
    List<Play> _repositories = widget._repositories;

    return ListView.builder(
      itemBuilder: (context, int index) {
        final repository = _repositories[index];
        return _buildCard(repository);
      },
      itemCount: _repositories.length,
    );
  }

  Widget _buildCard(Play play) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
              child: ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: Text(play.title),
                    ),
                    _playMenuButton(context, play),
                  ],
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(play.requesterName),
                    Padding(padding: EdgeInsets.only(left: 10)),
                    Text(play.groupName),
                  ],
                ),
              )),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 10.0),
            child: Text(play.text),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(DateFormat('yyyy/MM/dd HH:mm').format(play.createdAt) +
                      ' 投稿'),
                  Text(DateFormat('yyyy/MM/dd HH:mm').format(play.updatedAt) +
                      ' 更新'),
                ],
              ))
        ],
      ),
    );
  }

  Widget _playMenuButton(BuildContext context, Play play) {
    return PopupMenuButton(
      icon: Icon(Icons.settings),
      onSelected: (newValue) {
        switch (newValue) {
          case 1:
            _navigateAndDisplayPlayDetailScreen(context, play);
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("内容確認"),
          value: 1,
        ),
        PopupMenuItem(
          child: Text("編集"),
          value: 2,
        ),
        PopupMenuItem(
          child: Text("削除"),
          value: 3,
        ),
        PopupMenuItem(
          child: Text("フォロー解除"),
          value: 4,
        ),
      ],
    );
  }

  _navigateAndDisplayPlayDetailScreen(BuildContext context, Play play) async {
    final checkedItems = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PlayDetailScreen(play: play),
      ),
    );
  }
}
