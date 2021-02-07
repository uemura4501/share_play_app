import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/repositories/MemberRepository.dart';

class NewMemberScreen extends StatefulWidget {
  NewMemberScreen({Key key}) : super(key: key);
  @override
  _NewMemberScreenState createState() => new _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
  var duplicateItems = List<Member>();
  var items = List<Member>();
  List<Member> _isChecked = [];

  @override
  void initState() {
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Member> dummySearchList = List<Member>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<Member> dummyListData = List<Member>();
      dummySearchList.forEach((item) {
        if (item.lastNameKana.contains(query) ||
            item.firstNameKana.contains(query) ||
            item.firstName.contains(query) ||
            item.lastName.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
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
        title: Text(
          'グループにメンバーを追加',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {},
            child: Text("保存"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Material(
                    color: Colors.grey[300],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.search, color: Colors.grey),
                        Expanded(
                          child: TextField(
                            // textAlign: TextAlign.center,
                            decoration: InputDecoration.collapsed(
                              hintText: '氏名絞り込み検索',
                            ),
                            onChanged: (value) {
                              filterSearchResults(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: FutureBuilder<List<Member>>(
                future: MemberRepository.getMembers('aaa'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    duplicateItems = snapshot.data;
                    if (items.isEmpty) {
                      items.addAll(snapshot.data);
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                              '${items[index].lastName} ${items[index].firstName}'),
                          value: _isChecked.contains(items[index]),
                          onChanged: (bool value) {
                            if (value) {
                              //チェックon
                              setState(() {
                                _isChecked.add(items[index]);
                              });
                            } else {
                              //チェックoff
                              setState(() {
                                _isChecked.remove(items[index]);
                              });
                            }
                          },
                          secondary: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage("${items[index].iconUrl}"),
                            backgroundColor: Colors.transparent,
                          ),
                        );
                      },
                    );
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
          ],
        ),
      ),
    );
  }
}
