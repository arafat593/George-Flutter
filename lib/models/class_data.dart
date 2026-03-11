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
  final String type;  // Changed from ClassType
  final String duration;
  final DateTime scheduledAt;
  final int maxParticipants;
  final bool isFree;
  final String id;
  final String status;  // Changed from ClassStatus
  final String courseId;
  final String instructorId;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int bookedSeats;
  final int availableSeats;
  final String difficulty;  // Changed from Difficulty
  final String gender;  // Changed from Gender
  final double price;
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
      type: json['type'] ?? '',
      duration: json['duration'] ?? '',
      scheduledAt: DateTime.parse(json['scheduledAt']),
      maxParticipants: (json['maxParticipants'] as num?)?.toInt() ?? 0,
      isFree: json['isFree'] ?? false,
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      courseId: json['courseId'] ?? '',
      instructorId: json['instructorId'] ?? '',
      order: (json['order'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      bookedSeats: (json['bookedSeats'] as num?)?.toInt() ?? 0,
      availableSeats: (json['availableSeat'] as num?)?.toInt() ?? 0,
      difficulty: json['difficulty'] ?? '',
      gender: json['gender'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
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
      'type': type,
      'duration': duration,
      'scheduledAt': scheduledAt.toIso8601String(),
      'maxParticipants': maxParticipants,
      'isFree': isFree,
      'id': id,
      'status': status,
      'courseId': courseId,
      'instructorId': instructorId,
      'order': order,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'bookedSeats': bookedSeats,
      'availableSeats': availableSeats,
      'difficulty': difficulty,
      'gender': gender,
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
    return {'id': id, 'name': name, 'email': email, 'avatar': avatar};
  }
}

// You can remove all the extension classes below:
// - ClassTypeX
// - ClassStatusX  
// - DifficultyX
// - GenderX