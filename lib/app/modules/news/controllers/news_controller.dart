import 'package:get/get.dart';

class NewsController extends GetxController {
  // Add logic to fetch news if needed
  final newsItems = [
    {
      'image': '',
      'date': 'Wed Dec 10 2025',
      'title': 'New Morning Yoga Classes Added',
      'description':
          "We've added new morning yoga sessions to help you start your day with calm energy and focus. Join now and refresh your routine.",
      'isBookable': true,
      'price': 'QAR 200',
      'time': '8:00-8:30 PM',
      'showGenderIcons': true,
    },
    {
      'image': '',
      'date': 'Wed Dec 10 2025',
      'title': 'Special Workshop This Weekend',
      'description':
          'Join our special weekend workshop focused on flexibility, breathing, and relaxation. Limited seats available.',
      'isBookable': true,
      'price': 'QAR 150',
      'time': '10:00-11:30 AM',
    },
    {
      'image': '',
      'date': 'Wed Dec 10 2025',
      'title': 'Improve Your Flexibility in 30 Days',
      'description':
          'Discover how regular yoga practice can improve your flexibility and reduce stress in just 30 days.\n\nLearn the science behind mindful movement and how small daily efforts can lead to significant changes in your physical and mental well-being.',
      'isBookable': false,
    },
  ].obs;
}
