// about_model.dart
class AboutModel {
  final int activeMembers;
  final int totalClasses;
  final int totalInstructors;
  final String ourStory;
  final String ourMission;
  final String location;
  final String locationMapLink;
  final String email;
  final String phoneNumber;
  final String instagramAccount;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  AboutModel({
    required this.activeMembers,
    required this.totalClasses,
    required this.totalInstructors,
    required this.ourStory,
    required this.ourMission,
    required this.location,
    required this.locationMapLink,
    required this.email,
    required this.phoneNumber,
    required this.instagramAccount,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      activeMembers: json['activeMembers'] ?? 0,
      totalClasses: json['totalClasses'] ?? 0,
      totalInstructors: json['totalInstructors'] ?? 0,
      ourStory: json['ourStory'] ?? '',
      ourMission: json['ourMission'] ?? '',
      location: json['location'] ?? '',
      locationMapLink: json['locationMapLink'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      instagramAccount: json['instagramAccount'] ?? '',
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeMembers': activeMembers,
      'totalClasses': totalClasses,
      'totalInstructors': totalInstructors,
      'ourStory': ourStory,
      'ourMission': ourMission,
      'location': location,
      'locationMapLink': locationMapLink,
      'email': email,
      'phoneNumber': phoneNumber,
      'instagramAccount': instagramAccount,
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}