class ProgressReport {
  ///返信ID
  final int id;

  ///所属する祈りID
  final int playId;

  ///経過報告内容
  String text;

  ///経過報告ユーザーID
  final int progressReportUserId;

  ///経過報告ユーザー名
  final String progressReportUserName;

  ///投稿日時
  final DateTime createdAt;

  ///更新日時
  final DateTime updatedAt;

  ProgressReport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        playId = json['play_id'],
        text = json['text'],
        progressReportUserId = json['progress_report_user_id'],
        progressReportUserName = json['progress_report_name'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'].toString())
            : null;
}
