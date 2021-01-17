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
        title: Text('グループにメンバーを追加'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
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
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                      NetworkImage("${items[index].iconUrl}"),
                                  backgroundColor: Colors.transparent,
                                ),
                                Text(
                                    '${items[index].lastName} ${items[index].firstName}'),
                              ],
                            ),
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
