import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/repositories/GroupMemberRepository.dart';
import 'package:share_play_app/screens/group/new_member_screen.dart';

class GroupMemberScreen extends StatefulWidget {
  Group group;
  GroupMemberScreen({Key key, @required this.group}) : super(key: key);
  @override
  _NewGroupScreenState createState() => new _NewGroupScreenState();
}

class _NewGroupScreenState extends State<GroupMemberScreen> {
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
        title: Text('${widget.group.groupName} のメンバー'),

        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => saveGroup(context),
            child: Text("保存"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Container(
        child: Column(children: <Widget>[
          FutureBuilder<List<Member>>(
            future: GroupMemberRepository.getMembers(widget.group.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                _repositories = snapshot.data;
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: _repositories.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Row(
                      children: <Widget>[
                        Text(
                            '${_repositories[index].lastName} ${_repositories[index].firstName}'),
                        _memberTypeMenuButton(_repositories[index]),
                        Text(
                          _repositories[index].getMemberTypeString(),
                        ),
                      ],
                    ),
                    value: _repositories.contains(_repositories[index]),
                    secondary: CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage("${_repositories[index].iconUrl}"),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                },
              );
            },
          ),
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
    if (checkedItems != null) {
      setState(() {
        _repositories = checkedItems;
      });
    }
  }

  Widget _memberTypeMenuButton(Member member) {
    return PopupMenuButton(
      icon: Icon(Icons.settings),
      onSelected: (newValue) {
        setState(() {
          if (newValue == 2) {
            _repositories.removeWhere((item) => item.id == member.id);
          } else {
            member.memberType = newValue;
          }
        });
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text("メンバーにする"),
          value: 0,
        ),
        PopupMenuItem(
          child: Text("管理者にする"),
          value: 1,
        ),
        PopupMenuItem(
          child: Text("削除する"),
          value: 2,
        ),
      ],
    );
  }

  saveGroup(BuildContext context) {}
}
