import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_play_app/models/models.dart';

class CreateNewPlayRepository {
  static Future<bool> createNewPlay(Play new_play) async {
    bool result = false;

    String mode = 'demo';

    if (mode != 'demo') {
      String body = json.encode({
        'play': new_play,
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
