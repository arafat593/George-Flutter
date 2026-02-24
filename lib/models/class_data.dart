class ClassesResponse {
  final List<ClassModel> classes;
  final int total;
  final int page;
  final int pageSize;
  final int totalPages;

  ClassesResponse({
    required this.classes,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  factory ClassesResponse.fromJson(Map<String, dynamic> json) {
    return ClassesResponse(
      classes: (json['classes'] as List)
          .map((e) => ClassModel.fromJson(e))
          .toList(),
      total: json['total'] ?? 0,
      page: json['page'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classes': classes.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'pageSize': pageSize,
      'totalPages': totalPages,
    };
  }
}
class ClassModel {
  final String title;
  final String description;
  final ClassType type;
  final int duration;
  final DateTime scheduledAt;
  final int maxParticipants;
  final bool isFree;
  final String id;
  final ClassStatus status;
  final String courseId;
  final String instructorId;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int bookedSeats;
  final int availableSeats;
  final Difficulty difficulty;
  final Gender gender;
  final int price;
  final String location;
  final String locationMapLink;
  final String phone;
  final String? imageUrl;
  final Instructor instructor;

  ClassModel({
    required this.title,
    required this.description,
    required this.type,
    required this.duration,
    required this.scheduledAt,
    required this.maxParticipants,
    required this.isFree,
    required this.id,
    required this.status,
    required this.courseId,
    required this.instructorId,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    required this.bookedSeats,
    required this.availableSeats,
    required this.difficulty,
    required this.gender,
    required this.price,
    required this.location,
    required this.locationMapLink,
    required this.phone,
    this.imageUrl,
    required this.instructor,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: ClassTypeX.fromString(json['type'] ?? ''),
      duration: json['duration'] ?? 0,
      scheduledAt: DateTime.parse(json['scheduledAt']),
      maxParticipants: json['maxParticipants'] ?? 0,
      isFree: json['isFree'] ?? false,
      id: json['id'] ?? '',
      status: ClassStatusX.fromString(json['status'] ?? ''),
      courseId: json['courseId'] ?? '',
      instructorId: json['instructorId'] ?? '',
      order: json['order'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      bookedSeats: json['bookedSeats'] ?? 0,
      availableSeats: json['availableSeats'] ?? 0,
      difficulty: DifficultyX.fromString(json['difficulty'] ?? ''),
      gender: GenderX.fromString(json['gender'] ?? ''),
      price: json['price'] ?? 0,
      location: json['location'] ?? '',
      locationMapLink: json['locationMapLink'] ?? '',
      phone: json['phone'] ?? '',
      imageUrl: json['imageUrl'],
      instructor: Instructor.fromJson(json['instructor']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': type.value,
      'duration': duration,
      'scheduledAt': scheduledAt.toIso8601String(),
      'maxParticipants': maxParticipants,
      'isFree': isFree,
      'id': id,
      'status': status.value,
      'courseId': courseId,
      'instructorId': instructorId,
      'order': order,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'bookedSeats': bookedSeats,
      'availableSeats': availableSeats,
      'difficulty': difficulty.value,
      'gender': gender.value,
      'price': price,
      'location': location,
      'locationMapLink': locationMapLink,
      'phone': phone,
      'imageUrl': imageUrl,
      'instructor': instructor.toJson(),
    };
  }
}
class Instructor {
  final String id;
  final String name;
  final String email;
  final String? avatar;

  Instructor({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
enum ClassType {
  live,
}

enum ClassStatus {
  completed,
  scheduled,
}

enum Difficulty {
  beginner,
  intermediate,
  advanced,
}

enum Gender {
  male,
  female,
  both,
}
extension ClassTypeX on ClassType {
  String get value => name.toUpperCase();

  static ClassType fromString(String value) {
    return ClassType.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => ClassType.live,
    );
  }
}

extension ClassStatusX on ClassStatus {
  String get value => name.toUpperCase();

  static ClassStatus fromString(String value) {
    return ClassStatus.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () => ClassStatus.scheduled,
    );
  }
}

extension DifficultyX on Difficulty {
  String get value =>
      name[0].toUpperCase() + name.substring(1); // Beginner

  static Difficulty fromString(String value) {
    return Difficulty.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => Difficulty.beginner,
    );
  }
}

extension GenderX on Gender {
  String get value =>
      name[0].toUpperCase() + name.substring(1); // Male

  static Gender fromString(String value) {
    return Gender.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => Gender.both,
    );
  }
}