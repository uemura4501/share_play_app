import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_play_app/models/group.dart';
import 'package:share_play_app/models/member.dart';

class SaveGroupMemberRepository {
  static Future<bool> saveGroupMember(Group group, List<Member> members) async {
    bool result = false;

    String mode = 'demo';

    if (mode != 'demo') {
      String body = json.encode({
        'group_id': group.id,
        'members': members,
      });
      final response = await http.post(
          'https://api.github.com/search/repositories?q=' +
              '&sort=stars&order=desc',
          body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> decoded = json.decode(response.body);
        result = decoded['result'];
      } else {
        throw Exception('Fail to everyone repository');
      }
    } else {
      result = true;
    }

    return result;
  }
}
