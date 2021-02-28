import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/repositories/GroupMemberRepository.dart';
import 'package:share_play_app/repositories/SaveGroupMemberRepository.dart';
import 'package:share_play_app/screens/group/new_member_screen.dart';

class GroupMemberScreen extends StatefulWidget {
  Group group;
  GroupMemberScreen({Key key, @required this.group}) : super(key: key);
  @override
  _NewGroupScreenState createState() => new _NewGroupScreenState();
}

class _NewGroupScreenState extends State<GroupMemberScreen> {
  List<Member> _repositories = new List<Member>();
  StreamController<List<Member>> _memberListStream;

  @override
  void initState() {
    super.initState();
    _memberListStream = StreamController<List<Member>>();
    GroupMemberRepository.getMembers(widget.group.id).then((groupMembers) {
      _memberListStream.add(groupMembers);
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
          StreamBuilder(
            stream: _memberListStream.stream,
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
        builder: (context) =>
            new NewMemberScreen(checkedItems: new List<Member>()),
      ),
    );
    if (checkedItems != null) {
      setState(() {
        for (var checkedItem in checkedItems) {
          var exist = _repositories.firstWhere(
              (element) => element.id == checkedItem.id,
              orElse: () => null);
          if (exist == null) {
            _repositories.add(checkedItem);
          }
        }
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

  saveGroup(BuildContext context) {
    SaveGroupMemberRepository.saveGroupMember(widget.group, _repositories)
        .then((result) {
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
