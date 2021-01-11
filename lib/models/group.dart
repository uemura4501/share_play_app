class Group {
  ///グループID
  final int id;

  ///グループ名
  final String groupName;

  ///グループiconのURL
  final String iconUrl;

  ///投稿日時
  final DateTime createdAt;

  ///更新日時
  final DateTime updatedAt;

  Group.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        groupName = json['group_name'],
        iconUrl = json['icon_url'],
        createdAt = DateTime.parse(json['created_at'].toString()),
        updatedAt = DateTime.parse(json['updated_at'].toString());
}
