import 'package:flutter/material.dart';
import 'package:share_play_app/models/models.dart';
import 'package:share_play_app/repositories/GroupRepository.dart';

class GroupScreen extends StatefulWidget {
  GroupScreen({Key key}) : super(key: key);
  @override
  _GroupScreenState createState() => new _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  TextEditingController editingController = TextEditingController();

  var duplicateItems = List<Group>();
  var items = List<Group>();

  @override
  void initState() {
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Group> dummySearchList = List<Group>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<Group> dummyListData = List<Group>();
      dummySearchList.forEach((item) {
        if (item.groupName.contains(query)) {
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
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
            padding: const EdgeInsets.only(top: 20),
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
                          hintText: ' グループ絞り込み検索',
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
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<Group>>(
                future: GroupRepository.getGroup('aaa'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    duplicateItems = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    NetworkImage("${items[index].iconUrl}"),
                                backgroundColor: Colors.transparent,
                              ),
                              Text('${items[index].groupName}'),
                            ],
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
