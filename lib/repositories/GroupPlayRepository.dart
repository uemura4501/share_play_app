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
          "id": 1,
          "title": "家族の癒やしのために",
          "text": "私の姉が風邪を長引かせています。癒やしのためにお祈りお願いします。",
          "requester_name": "田中 栄三郎",
          "requester_id": 1,
          "group_id": 2,
          "group_name": "青年会",
          "follow_num": 12,
          "progress_reports": [
            {
              "id": 1,
              "play_id": 1,
              "text": "少し熱が下がってきました。",
              "progress_report_user_id": 1,
              "progress_report_name": "田中 栄三郎",
              "created_at": "2021-01-10 21:39:10",
              "updated_at": "2021-01-10 21:40:10",
            },
            {
              "id": 2,
              "play_id": 1,
              "text": "だいぶ熱が下がってきました。",
              "progress_report_user_id": 1,
              "progress_report_name": "田中 栄三郎",
              "created_at": "2021-01-11 21:39:10",
              "updated_at": "2021-01-11 21:40:10",
            },
          ],
          "replies": [
            {
              "id": 1,
              "play_id": 1,
              "text": "大丈夫ですか。お祈りしてます。",
              "reply_user_id": 4,
              "reply_user_name": "佐藤 健太郎",
              "created_at": "2021-01-10 22:39:10",
              "updated_at": "2021-01-10 22:40:10",
            },
            {
              "id": 2,
              "play_id": 1,
              "text": "少し下がったと聞いて、少し安心しました。引き続きお祈りしてます。",
              "reply_user_id": 4,
              "reply_user_name": "佐藤 健太郎",
              "created_at": "2021-01-11 22:39:10",
              "updated_at": "2021-01-11 22:40:10",
            },
          ],
          "created_at": "2021-01-09 21:39:10",
          "updated_at": "2021-01-09 21:40:10",
        }),
        new Play.fromJson({
          "id": 1,
          "title": "家族の癒やしのために",
          "text": "私の姉が風邪を長引かせています。癒やしのためにお祈りお願いします。",
          "requester_id": 1,
          "requester_name": "田中 栄三郎",
          "group_id": 2,
          "group_name": "青年会",
          "follow_num": 25,
          "created_at": "2021-01-09 21:39:10",
          "updated_at": "2021-01-09 21:40:10",
        })
      ];
    }

    return list;
  }
}
