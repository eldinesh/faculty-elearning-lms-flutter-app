class UserData {
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? dateOfBirth;
  String? address;
  String? image;
  bool? isEmailAdded;
  bool? isPhoneAdded;
  bool? isFbConnected;
  bool? isGoogleConnected;
  bool? isTwitterConnected;
  bool? isAppleConnected;

  UserData({
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.gender, 
    this.phone,
    this.dateOfBirth,
    this.address,
    this.image,
    this.isEmailAdded,
    this.isPhoneAdded,
    this.isFbConnected,
    this.isGoogleConnected,
    this.isTwitterConnected,
    this.isAppleConnected,
  });

  factory UserData.fromJson(Map<String, Object?> json) => UserData(
        name: json['name'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        email: json['email'] as String?,
        gender: json['gender'] as String?,
        phone: json['phone'] as String?,
        dateOfBirth: json['date_of_birth'] as String?,
        address: json['address'] as String?,
        image: json['image'] as String?,
        isEmailAdded: json['is_email_added'] as bool?,
        isPhoneAdded: json['is_phone_added'] as bool?,
        isFbConnected: json['is_fb_connected'] as bool?,
        isGoogleConnected: json['is_google_connected'] as bool?,
        isTwitterConnected: json['is_twitter_connected'] as bool?,
        isAppleConnected: json['is_apple_connected'] as bool?,
      );

  Map<String, Object?> toJson() => {
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'gender': gender,
        'phone': phone,
        'date_of_birth': dateOfBirth,
        'address': address,
        'image': image,
        'is_email_added': isEmailAdded,
        'is_phone_added': isPhoneAdded,
        'is_fb_connected': isFbConnected,
        'is_google_connected': isGoogleConnected,
        'is_twitter_connected': isTwitterConnected,
        'is_apple_connected': isAppleConnected,
      };
}
