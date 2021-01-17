import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_play_app/models/models.dart';

class MemberRepository {
  static Future<List<Member>> getMembers(String searchWord) async {
    List<Member> list = [];

    String mode = 'demo';

    if (mode != 'demo') {
      final response = await http.get(
          'https://api.github.com/search/repositories?q=' +
              searchWord +
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
          'id': 1,
          'last_name': '高田',
          'first_name': '一郎',
          'last_name_kana': 'たかだ',
          'first_name_kana': 'いちろう',
          'icon_url':
              'https://www.pakutaso.com/shared/img/thumb/PPG_ameninuretamomiji_TP_V.jpg',
          'memberType': 0,
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        }),
        new Member.fromJson({
          'id': 2,
          'last_name': '鈴木',
          'first_name': '健太郎',
          'last_name_kana': 'すずき',
          'first_name_kana': 'けんたろう',
          'icon_url':
              'https://www.pakutaso.com/shared/img/thumb/017RED1124_TP_V.jpg',
          'memberType': 0,
          'created_at': '2021-01-09 21:39:10',
          'updated_at': '2021-01-09 21:40:10',
        })
      ];
    }

    return list;
  }
}
