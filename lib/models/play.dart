import 'package:share_play_app/models/progressReport.dart';
import 'package:share_play_app/models/reply.dart';

class Play {
  ///祈りID
  final int id;

  ///祈りのタイトル
  String title;

  ///祈りの要請内容
  String text;

  ///祈りの要請者ID
  final int requesterId;

  ///祈りの要請者名
  final String requesterName;

  ///祈りの所属グループID
  final int groupId;

  ///祈りの所属グループ名
  final String groupName;

  ///フォロー数
  final int followNum;

  ///経過報告
  final List<ProgressReport> progressReports;

  ///返信
  final List<Reply> replies;

  ///投稿日時
  final DateTime createdAt;

  ///更新日時
  final DateTime updatedAt;

  Play.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        requesterId = json['requester_id'],
        requesterName = json['requester_name'],
        groupId = json['group_id'],
        groupName = json['group_name'],
        followNum = json['follow_num'],
        progressReports = json['progress_reports'] != null
            ? (json['progress_reports'] as List).map((i) {
                return new ProgressReport.fromJson(i);
              }).toList()
            : new List<ProgressReport>(),
        replies = json['replies'] != null
            ? (json['replies'] as List).map((i) {
                return new Reply.fromJson(i);
              }).toList()
            : new List<Reply>(),
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'].toString())
            : null;
}
