import '../common/section.dart';
import '../common/course.dart';
import 'faq.dart';
import 'features.dart';
import '../common/instructor.dart';
import '../common/organization.dart';
import 'resources.dart';

class CourseDetailData {
  int? id;
  String? title;
  String? slug;
  String? shortDescription;
  String? description;
  String? thumbnail;
  String? videoSource;
  String? videoLink;
  String? price;
  bool? isDiscounted;
  String? discountType;
  String? discountedPrice;
  bool? isWishlistAdded;
  bool isAddedToCart;
  Features? features;
  List<Instructor>? instructors;
  List<Section>? sections;
  Resources? resources;
  List<Course>? relatedCourses;
  List<Faq>? faqs;
  Organization? organization;
  String? contactNo;
  int? totalReviews;
  String? avgRatings;
  bool? isReviewed;
  bool? canReview;

  CourseDetailData({
    this.id,
    this.title,
    this.slug,
    this.shortDescription,
    this.description,
    this.thumbnail,
    this.videoSource,
    this.videoLink,
    this.price,
    this.isDiscounted,
    this.discountType,
    this.discountedPrice,
    this.isWishlistAdded,
    this.isAddedToCart = false,
    this.features,
    this.instructors,
    this.sections,
    this.resources,
    this.relatedCourses,
    this.faqs,
    this.organization,
    this.contactNo,
    this.totalReviews,
    this.avgRatings,
    this.isReviewed,
    this.canReview,
  });

  factory CourseDetailData.fromJson(Map<String, Object?> json) =>
      CourseDetailData(
        id: json['id'] as int?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        shortDescription: json['short_description'] as String?,
        description: json['description'] as String?,
        thumbnail: json['thumbnail'] as String?,
        videoSource: json['video_source'] as String?,
        videoLink:
            json['video_link'] != null ? json['video_link'] as String? : null,
        price: json['price'] as String?,
        isDiscounted: json['is_discounted'] as bool?,
        discountType: json['discount_type'] as String?,
        discountedPrice: json['discounted_price'] as String?,
        isWishlistAdded: json['is_wishlist_added'] as bool?,
        isAddedToCart: json['is_cartlist_added'] != null
            ? json['is_cartlist_added'] as bool
            : false,
        features: json['features'] == null
            ? null
            : Features.fromJson(json['features']! as Map<String, Object?>),
        instructors: (json['instructors'] as List<dynamic>?)
            ?.map((e) => Instructor.fromJson(e as Map<String, Object?>))
            .toList(),
        sections: (json['sections'] as List<dynamic>?)
            ?.map((e) => Section.fromJson(e as Map<String, Object?>))
            .toList(),
        resources: json['resources'] == null
            ? null
            : Resources.fromJson(json['resources']! as Map<String, Object?>),
        relatedCourses: (json['related_courses'] as List<dynamic>?)
            ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
            .toList(),
        faqs: (json['faqs'] as List<dynamic>?)
            ?.map((e) => Faq.fromJson(e as Map<String, Object?>))
            .toList(),
        organization: json['organization'] == null
            ? null
            : Organization.fromJson(
                json['organization']! as Map<String, Object?>),
        contactNo: json['contact_no'] as String?,
        totalReviews: json['total_reviews'] as int?,
        avgRatings: json['avg_ratings'] as String?,
        isReviewed: json['is_reviewed'] as bool?,
        canReview: json['can_review'] as bool?,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'title': title,
        'slug': slug,
        'short_description': shortDescription,
        'description': description,
        'thumbnail': thumbnail,
        'video_source': videoSource,
        'video_link': videoLink,
        'price': price,
        'is_discounted': isDiscounted,
        'discount_type': discountType,
        'discounted_price': discountedPrice,
        'is_wishlist_added': isWishlistAdded,
        'is_cartlist_added': isAddedToCart,
        'features': features?.toJson(),
        'instructors': instructors?.map((e) => e.toJson()).toList(),
        'sections': sections?.map((e) => e.toJson()).toList(),
        'resources': resources?.toJson(),
        'related_courses': relatedCourses?.map((e) => e.toJson()).toList(),
        'faqs': faqs?.map((e) => e.toJson()).toList(),
        'organization': organization?.toJson(),
        'contact_no': contactNo,
        'total_reviews': totalReviews,
        'avg_ratings': avgRatings,
        'is_reviewed': isReviewed,
        'can_review': canReview,
      };
}
