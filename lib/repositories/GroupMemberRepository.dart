import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_play_app/models/models.dart';

class GroupMemberRepository {
  static Future<List<Member>> getDefaultMembers() async {
    List<Member> list = [];

    return list;
  }

  static Future<List<Member>> getMembers(int group_id) async {
    List<Member> list = [];

    String mode = 'demo';

    if (mode != 'demo') {
      final response = await http.get(
          'https://api.github.com/search/repositories?q=' +
              group_id.toString() +
              '&sort=stars&order=desc');
      if (response.statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(response.body);
        for (var item in decoded['items']) {
          list.add(Member.fromJson(item));
        }
      } else {
        throw Exception('Fail to everyone repository');
      }
    } else {
      list = [
        new Member.fromJson({
          'id': 4,
          'last_name': '佐藤',
          'first_name': '健太郎',
          'last_name_kana': 'さとう',
          'first_name_kana': 'けんたろう',
          'icon_url':
              'https://www.pakutaso.com/shared/img/thumb/017RED1124_TP_V.jpg',
          'member_type': 0,
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        }),
        new Member.fromJson({
          'id': 5,
          'last_name': '中田',
          'first_name': '健太郎',
          'last_name_kana': 'なかた',
          'first_name_kana': 'けんたろう',
          'icon_url':
              'https://www.pakutaso.com/shared/img/thumb/017RED1124_TP_V.jpg',
          'member_type': 1,
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        })
      ];
    }

    return list;
  }
}
