class Play {
  ///祈りID
  final int id;

  ///祈りのタイトル
  final String title;

  ///祈りの要請内容
  final String text;

  ///祈りの要請者名
  final String requesterName;

  ///祈りの所属グループ名
  final String groupName;

  ///投稿日時
  final DateTime createdAt;

  ///更新日時
  final DateTime updatedAt;

  Play.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'],
        requesterName = json['requester_name'],
        groupName = json['group_name'],
        createdAt = DateTime.parse(json['created_at'].toString()),
        updatedAt = DateTime.parse(json['updated_at'].toString());
}
