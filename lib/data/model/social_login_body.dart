class SocialLogInBody {
  String? name;
  String? email;
  String? uid;
  String? phone;

  SocialLogInBody({this.email, this.uid, this.name, this.phone});

  SocialLogInBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    uid = json['uid'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['uid'] = uid;
    data['phone'] = phone;
    return data;
  }
}
