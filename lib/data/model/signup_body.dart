class SignUpBody {
  String? fName;
  String? lName;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;

  SignUpBody(
      {this.fName,
      this.lName,
      this.email = '',
      this.password,
      this.phone,
      this.confirmPassword});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    fName = json['first_name'];
    lName = json['last_name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = fName;
    data['last_name'] = lName;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = confirmPassword;
    return data;
  }

   Map<String, dynamic> toJsonForPhone() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = fName;
    data['last_name'] = lName;
    data['phone'] = phone;
    return data;
  }
}
