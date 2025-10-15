import 'package:get/get.dart';

class EarningsController extends GetxController {
  final selectedTab = 'Daily'.obs;
  final earnings = 678.0.obs;

  void changeTab(String tab) {
    selectedTab.value = tab;
    // Here you can add logic to update earnings based on the selected tab
    updateEarnings();
  }

  void updateEarnings() {
    // Add your logic to fetch/update earnings based on the selected tab
    // For example:
    // if (selectedTab.value == 'Daily') {
    //   earnings.value = _fetchDailyEarnings();
    // } else if (selectedTab.value == 'Weekly') {
    //   earnings.value = _fetchWeeklyEarnings();
    // } else {
    //   earnings.value = _fetchMonthlyEarnings();
    // }
  }

  String get dateRangeText {
    final now = DateTime.now();
    if (selectedTab.value == 'Daily') {
      return 'Today: ${_formatDate(now)}';
    } else if (selectedTab.value == 'Weekly') {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      return '${_formatDate(startOfWeek)} - ${_formatDate(endOfWeek)}';
    } else {
      return '${_getMonthName(now.month)} ${now.year}';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)}';
  }

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }
}
