import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_play_app/models/models.dart';

class GroupRepository {
  static Future<List<Group>> getGroup(String searchWord) async {
    List<Group> list = [];

    String mode = 'demo';

    if (mode != 'demo') {
      final response = await http.get(
          'https://api.github.com/search/repositories?q=' +
              searchWord +
              '&sort=stars&order=desc');
      if (response.statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(response.body);
        for (var item in decoded['items']) {
          list.add(Group.fromJson(item));
        }
      } else {
        throw Exception('Fail to everyone repository');
      }
    } else {
      list = [
        new Group.fromJson({
          'id': 1,
          'group_name': '課長会',
          'icon_url':
              'https://www.pakutaso.com/shared/img/thumb/PPG_ameninuretamomiji_TP_V.jpg',
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        }),
        new Group.fromJson({
          'id': 2,
          'group_name': '青年会',
          'icon_url':
              'https://www.pakutaso.com/shared/img/thumb/017RED1124_TP_V.jpg',
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        })
      ];
    }

    return list;
  }
}
