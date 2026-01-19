import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt selectedDateIndex = 3.obs;
  final RxBool isMembershipPaid = true.obs;

  final Rx<DateTime> currentMonth = DateTime(2025, 11).obs;

  final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String get currentMonthName => monthNames[currentMonth.value.month - 1];
  int get currentYear => currentMonth.value.year;

  // Using a more standard initialization for RxList
  final dates = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    generateDates();
  }

  void generateDates() {
    dates.clear();
    int year = currentMonth.value.year;
    int month = currentMonth.value.month;

    // Get the last day of the current month
    int daysInMonth = DateTime(year, month + 1, 0).day;

    final List<String> weekDays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      dates.add({'day': weekDays[date.weekday - 1], 'date': i.toString()});
    }
  }

  void nextMonth() {
    int nextMonth = currentMonth.value.month + 1;
    int year = currentMonth.value.year;
    if (nextMonth > 12) {
      nextMonth = 1;
      year++;
    }
    currentMonth.value = DateTime(year, nextMonth);
    generateDates();
  }

  void previousMonth() {
    int prevMonth = currentMonth.value.month - 1;
    int year = currentMonth.value.year;
    if (prevMonth < 1) {
      prevMonth = 12;
      year--;
    }
    currentMonth.value = DateTime(year, prevMonth);
    generateDates();
  }

  void setSelectedDate(int index) {
    selectedDateIndex.value = index;
  }
}
