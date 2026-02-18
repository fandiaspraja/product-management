import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension PriceFormatting on int {
  String formatPrice() {
    final locale = Get.locale?.languageCode ?? 'ar';
    final String symbol = locale == 'ar' ? 'رس' : 'SAR';
    final NumberFormat formatter = NumberFormat.decimalPattern(locale);
    return '${formatter.format(this)} $symbol';
  }
}
