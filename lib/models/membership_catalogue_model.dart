class MembershipResponseModel {
  final List<MembershipModel> memberships;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  MembershipResponseModel({
    required this.memberships,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory MembershipResponseModel.fromJson(Map<String, dynamic> json) {
    return MembershipResponseModel(
      memberships: (json['memberships'] as List)
          .map((e) => MembershipModel.fromJson(e))
          .toList(),
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
    );
  }
}

class MembershipModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int durationDays;
  final List<String> allowedClasses;
  final String? timeRestriction;
  final bool autoRenew;
  final String status;
  final int totalClasses;
  final List<ClassInfoModel> classDetails;
  final DateTime createdAt;
  final DateTime updatedAt;

  MembershipModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationDays,
    required this.allowedClasses,
    required this.timeRestriction,
    required this.autoRenew,
    required this.status,
    required this.totalClasses,
    required this.classDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      durationDays: json['durationDays'],
      allowedClasses: List<String>.from(json['allowedClasses'] ?? []),
      timeRestriction: json['timeRestriction'],
      autoRenew: json['autoRenew'] ?? false,
      status: json['status'],
      totalClasses: json['totalClasses'] ?? 0,
      classDetails: (json['classDetails'] as List)
          .map((e) => ClassInfoModel.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ClassInfoModel {
  final String id;
  final String title;
  final DateTime scheduledAt;
  final String duration;
  final String location;

  ClassInfoModel({
    required this.id,
    required this.title,
    required this.scheduledAt,
    required this.duration,
    required this.location,
  });

  factory ClassInfoModel.fromJson(Map<String, dynamic> json) {
    return ClassInfoModel(
      id: json['id'],
      title: json['title'],
      scheduledAt: DateTime.parse(json['scheduledAt']),
      duration: json['duration'],
      location: json['location'],
    );
  }
}
