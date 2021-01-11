import 'package:flutter/material.dart';
import 'package:share_play_app/models/play.dart';
import 'package:share_play_app/repositories/EveryoneRepository.dart';
import 'package:share_play_app/screens/component/play_card.dart';

class EveryoneScreen extends StatefulWidget {
  @override
  _EveryoneScreenState createState() => _EveryoneScreenState();
}

class _EveryoneScreenState extends State<EveryoneScreen> {
  List<Play> _repositories = new List();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Play>>(
        future: EveryoneRepository.getEveryone('aaa'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _repositories = snapshot.data;
            return PlayCard(_repositories);
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
    );
  }
}
