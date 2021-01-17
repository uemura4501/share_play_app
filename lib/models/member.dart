class Member {
  ///メンバーID
  final int id;

  ///氏
  final String lastName;

  ///名
  final String firstName;

  ///氏（かな）
  final String lastNameKana;

  ///名（かな）
  final String firstNameKana;

  ///メンバーiconのURL
  final String iconUrl;

  ///メンバー種類 0:未設定 1:普通 2：管理者
  final int memberType;

  ///投稿日時
  final DateTime createdAt;

  ///更新日時
  final DateTime updatedAt;

  Member.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lastName = json['last_name'],
        firstName = json['first_name'],
        lastNameKana = json['last_name_kana'],
        firstNameKana = json['first_name_kana'],
        memberType = json['member_type'],
        iconUrl = json['icon_url'],
        createdAt = DateTime.parse(json['created_at'].toString()),
        updatedAt = DateTime.parse(json['updated_at'].toString());
}
