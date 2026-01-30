import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final RxInt selectedDateIndex = (DateTime.now().day - 1).obs;
  final RxBool isMembershipPaid = true.obs;

  final Rx<DateTime> currentMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  ).obs;

  final ScrollController scrollController = ScrollController();

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

  String get selectedDateString {
    if (dates.isEmpty || selectedDateIndex.value >= dates.length) return '';
    final shortDay = dates[selectedDateIndex.value]['day'];
    final fullDay = _getFullDayName(shortDay ?? '');
    final date = dates[selectedDateIndex.value]['date'];
    final yearSuffix = currentYear.toString().substring(2);
    return '$fullDay $date ${currentMonthName.substring(0, 3)} $yearSuffix';
  }

  String get todayButtonText {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (dates.isEmpty || selectedDateIndex.value >= dates.length)
      return 'Today';
    final selected = DateTime(
      currentYear,
      currentMonth.value.month,
      selectedDateIndex.value + 1,
    );

    if (selected.year == today.year &&
        selected.month == today.month &&
        selected.day == today.day) {
      return 'Today';
    }

    final tomorrow = today.add(const Duration(days: 1));
    if (selected.year == tomorrow.year &&
        selected.month == tomorrow.month &&
        selected.day == tomorrow.day) {
      return 'Tomorrow';
    }

    final yesterday = today.subtract(const Duration(days: 1));
    if (selected.year == yesterday.year &&
        selected.month == yesterday.month &&
        selected.day == yesterday.day) {
      return 'Yesterday';
    }

    return 'Today';
  }

  String _getFullDayName(String shortName) {
    switch (shortName) {
      case 'Mon':
        return 'Monday';
      case 'Tue':
        return 'Tuesday';
      case 'Wed':
        return 'Wednesday';
      case 'Thu':
        return 'Thursday';
      case 'Fri':
        return 'Friday';
      case 'Sat':
        return 'Saturday';
      case 'Sun':
        return 'Sunday';
      default:
        return shortName;
    }
  }

  final dates = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();

    _initializeToToday();
  }

  void _initializeToToday() {
    final now = DateTime.now();
    currentMonth.value = DateTime(now.year, now.month);
    generateDates();
    selectedDateIndex.value = now.day - 1;
  }

  @override
  void onReady() {
    super.onReady();

    refreshToToday();
  }

  void refreshToToday() {
    _initializeToToday();
    scrollToSelectedDate();
  }

  void scrollToSelectedDate() {
    if (selectedDateIndex.value != -1) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (scrollController.hasClients) {
          double itemWidth = 68.0;
          double offset = selectedDateIndex.value * itemWidth;

          double screenWidth = Get.width;
          double targetOffset = offset - (screenWidth / 2) + (itemWidth / 2);

          if (targetOffset < 0) targetOffset = 0;
          if (targetOffset > scrollController.position.maxScrollExtent) {
            targetOffset = scrollController.position.maxScrollExtent;
          }

          scrollController.animateTo(
            targetOffset,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void generateDates() {
    int year = currentMonth.value.year;
    int month = currentMonth.value.month;

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

    final List<Map<String, String>> newDates = [];
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(year, month, i);
      newDates.add({'day': weekDays[date.weekday - 1], 'date': i.toString()});
    }
    dates.assignAll(newDates);
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

  void resetToToday() {
    _initializeToToday();
    scrollToSelectedDate();
  }

  void handleTodayButtonClick() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (dates.isEmpty || selectedDateIndex.value >= dates.length) {
      resetToToday();
      return;
    }

    final selected = DateTime(
      currentYear,
      currentMonth.value.month,
      selectedDateIndex.value + 1,
    );

    if (selected.year == today.year &&
        selected.month == today.month &&
        selected.day == today.day) {
      final tomorrow = today.add(const Duration(days: 1));
      currentMonth.value = DateTime(tomorrow.year, tomorrow.month);
      generateDates();
      selectedDateIndex.value = tomorrow.day - 1;
      scrollToSelectedDate();
    } else {
      resetToToday();
    }
  }

  Future<void> launchMaps() async {
    final Uri url = Uri.parse('https://www.google.com/maps');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not open maps');
    }
  }
}
