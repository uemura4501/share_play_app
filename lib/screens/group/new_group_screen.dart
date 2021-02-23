import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/repositories/CreateNewGroupRepository.dart';
import 'package:share_play_app/screens/group/new_member_screen.dart';

class NewGroupScreen extends StatefulWidget {
  NewGroupScreen({Key key}) : super(key: key);
  @override
  _NewGroupScreenState createState() => new _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  String groupName = '';
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

        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => createNewGroupAlert(context),
            child: Text("作成"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Container(
        child: Column(children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "グループ名"),
            onChanged: (value) {
              setState(() {
                groupName = value;
              });
            },
          ),
          Text('メンバー'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _repositories.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(
                    '${_repositories[index].lastName} ${_repositories[index].firstName}'),
                value: _repositories.contains(_repositories[index]),
                secondary: CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      NetworkImage("${_repositories[index].iconUrl}"),
                  backgroundColor: Colors.transparent,
                ),
              );
            },
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          _navigateAndDisplayNewMamberScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _navigateAndDisplayNewMamberScreen(BuildContext context) async {
    final checkedItems = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new NewMemberScreen(checkedItems: _repositories),
      ),
    );
    print(checkedItems);
    if (checkedItems != null) {
      setState(() {
        _repositories = checkedItems;
      });
    }
  }

  createNewGroupAlert(BuildContext context) {
    if (this.groupName.isEmpty) {
      return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('確認'),
          content: Text('グループ名が入力されていません。'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(0),
            ),
          ],
        ),
      );
    }
    if (this._repositories.isEmpty) {
      return showDialog(
        context: context,
        child: AlertDialog(
          title: Text('確認'),
          content: Text('メンバーが指定されていないため、あなた1人のみ所属のグループを作成しますが、よろしいですか？'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(0),
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(1);
                createNewGroup(context);
              },
            ),
          ],
        ),
      );
    } else {
      createNewGroup(context);
    }
  }

  createNewGroup(BuildContext context) {
    //  新しいグループを作成する
    CreateNewGroupRepository.createNewGroup(this.groupName, this._repositories)
        .then((result) {
      if (result) {
        Navigator.of(context).pop();
      } else {}
    });
  }
}
