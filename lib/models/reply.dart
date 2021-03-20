class Reply {
  ///返信ID
  final int id;

  ///所属する祈りID
  final int playId;

  ///返信内容
  String text;

  ///返信したユーザーID
  final int replyUserId;

  ///返信したユーザー名
  final String replyUserName;

  ///投稿日時
  final DateTime createdAt;

  ///更新日時
  final DateTime updatedAt;

  Reply.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        playId = json['play_id'],
        text = json['text'],
        replyUserId = json['reply_user_id'],
        replyUserName = json['reply_user_name'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'].toString())
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'].toString())
            : null;
}
