import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/repositories/MemberRepository.dart';

class NewMemberScreen extends StatefulWidget {
  final List<Member> checkedItems;
  NewMemberScreen({Key key, @required this.checkedItems}) : super(key: key);
  @override
  _NewMemberScreenState createState() => new _NewMemberScreenState();
}

class _NewMemberScreenState extends State<NewMemberScreen> {
  Future<List<Member>> futureItems;
  List<Member> items = [];
  List<Member> checkedItems = [];

  @override
  void initState() {
    super.initState();
    checkedItems = widget.checkedItems;
    futureItems = MemberRepository.getDefaultMembers();
  }

  void filterSearchResults(String query) {
    setState(() {
      //APIから取得
      futureItems = MemberRepository.getMembers(query);
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
        title: Text(
          'グループにメンバーを追加',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Navigator.pop(context, checkedItems);
            },
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
                              hintText: '氏名検索',
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
                future: futureItems,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    items.clear();
                    List<Member> tmpList = snapshot.data;

                    //検索APIで取得したリストの中に、チェック済みのmemberがあったらそれは除く
                    tmpList = tmpList.where((item) {
                      for (var checkedItem in checkedItems) {
                        if (item.id == checkedItem.id) {
                          return false;
                        }
                      }
                      return true;
                    }).toList();

                    items.addAll(tmpList);
                    items.addAll(checkedItems);

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                              '${items[index].lastName} ${items[index].firstName}'),
                          value: checkedItems.contains(items[index]),
                          onChanged: (bool value) {
                            if (value) {
                              //チェックon
                              setState(() {
                                checkedItems.add(items[index]);
                              });
                            } else {
                              //チェックoff
                              setState(() {
                                checkedItems.remove(items[index]);
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
