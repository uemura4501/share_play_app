import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_play_app/models/play.dart';

class MyselfRepository {
  static Future<List<Play>> getMyself(String searchWord) async {
    List<Play> list = [];

    String mode = 'demo';

    if (mode != 'demo') {
      final response = await http.get(
          'https://api.github.com/search/repositories?q=' +
              searchWord +
              '&sort=stars&order=desc');
      if (response.statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(response.body);
        for (var item in decoded['items']) {
          list.add(Play.fromJson(item));
        }
      } else {
        throw Exception('Fail to myself repository');
      }
    } else {
      list = [
        new Play.fromJson({
          'id': 1,
          'title': '職場の方の救いのために',
          'text': '職場の先輩が救いを求めています。福音が伝わり受け入れることができるようにお祈りお願いします。',
          'requester_name': '大崎　一郎',
          'group_name': '家長会',
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        })
      ];
    }

    return list;
  }
}
