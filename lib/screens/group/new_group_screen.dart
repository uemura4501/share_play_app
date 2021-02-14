import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_play_app/models/models.dart';
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
}
