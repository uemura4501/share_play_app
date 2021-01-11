import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_play_app/blocs/authentication/authentication.dart';
import 'package:share_play_app/screens/screens.dart';
import 'package:share_play_app/models/models.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  // 表示するページをリスト形式で宣言します
  List<Widget> _pageList = [
    GroupScreen(),
    EveryoneScreen(),
    MyselfScreen(),
    OtherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('グループ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('皆の祈りの課題'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            title: Text('自分の祈り'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('その他'),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
