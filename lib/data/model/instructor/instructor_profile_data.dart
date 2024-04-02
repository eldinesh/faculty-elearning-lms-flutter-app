import '../common/organization.dart';
import 'social_link.dart';

class InstructorProfileData {
  late String name;
  late String profilePic;
  late String designation;
  late String about;
  List<SocialLink>? socialLinks;
  late bool isFollowing;
  late int totalCourse;
  late int totalStudent;
  late int followers;
  Organization? organization;

  InstructorProfileData({
    this.profilePic = "",
    this.name = "",
    this.designation = "",
    this.about = "",
    this.socialLinks,
    this.isFollowing = false,
    this.totalCourse = 0,
    this.totalStudent = 0,
    this.followers = 0,
    this.organization,
  });

  factory InstructorProfileData.fromJson(Map<String, Object?> json) =>
      InstructorProfileData(
        profilePic: json['profile_pic'] as String,
        name: json['name'] as String,
        designation: json['designation'] as String,
        about: json['about'] as String,
        socialLinks: (json['social_links'] as List<dynamic>?)
            ?.map((e) => SocialLink.fromJson(e as Map<String, Object?>))
            .toList(),
        isFollowing: json['is_following'] as bool,
        totalCourse: json['total_course'] as int,
        totalStudent: json['total_student'] as int,
        followers: json['followers'] as int,
        organization: json['organization'] == null
            ? null
            : Organization.fromJson(
                json['organization']! as Map<String, Object?>),
      );

  Map<String, Object?> toJson() => {
        'profile_pic': profilePic,
        'name': name,
        'designation': designation,
        'about': about,
        'social_links': socialLinks?.map((e) => e.toJson()).toList(),
        'is_following': isFollowing,
        'total_course': totalCourse,
        'total_student': totalStudent,
        'followers': followers,
        'organization': organization,
      };
}
