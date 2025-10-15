import 'package:get/get.dart';

class PaymentOption {
  final String id;
  final String title;
  final String iconPath;
  final DateTime dueDate;
  final double amount;

  PaymentOption({
    required this.id,
    required this.title,
    required this.iconPath,
    required this.dueDate,
    required this.amount,
  });
}

class PaymentController extends GetxController {
  final RxList<PaymentOption> paymentOptions = <PaymentOption>[].obs;
  final RxDouble totalAmount = 3400.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePaymentOptions();
  }

  void _initializePaymentOptions() {
    final now = DateTime.now();
    
    paymentOptions.assignAll([
      PaymentOption(
        id: 'credit_card',
        title: 'Credit/Debit Card',
        iconPath: 'assets/icons/credit_card.svg',
        dueDate: now,
        amount: totalAmount.value,
      ),
      PaymentOption(
        id: 'bank_transfer',
        title: 'Bank Transfer',
        iconPath: 'assets/icons/bank.svg',
        dueDate: now,
        amount: totalAmount.value,
      ),
      PaymentOption(
        id: 'digital_wallet',
        title: 'Digital Wallet',
        iconPath: 'assets/icons/wallet.svg',
        dueDate: now,
        amount: totalAmount.value,
      ),
    ]);
  }
  
  String _formatDate(DateTime date) {
    return '${_getDayOfWeek(date.weekday)}, ${date.day} ${_getMonthName(date.month)}';
  }
  
  String _getDayOfWeek(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
  
  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
  
  String getFormattedDueDate(PaymentOption option) {
    if (option.id == 'pay_now') return 'Today';
    return _formatDate(option.dueDate);
  }
}
