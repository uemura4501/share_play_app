import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_play_app/models/play.dart';

class GroupPlayRepository {
  static Future<List<Play>> getGroupPlay(String searchWord) async {
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
        throw Exception('Fail to everyone repository');
      }
    } else {
      list = [
        new Play.fromJson({
          'id': 1,
          'title': '家族の癒やしのために',
          'text': '私の姉が風邪を長引かせています。癒やしのためにお祈りお願いします。',
          'requester_name': '田中 栄三郎',
          'requester_id': 1,
          'group_id': 2,
          'group_name': '青年会',
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        }),
        new Play.fromJson({
          'id': 1,
          'title': '家族の癒やしのために',
          'text': '私の姉が風邪を長引かせています。癒やしのためにお祈りお願いします。',
          'requester_id': 1,
          'requester_name': '田中 栄三郎',
          'group_id': 2,
          'group_name': '青年会',
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        })
      ];
    }

    return list;
  }
}
