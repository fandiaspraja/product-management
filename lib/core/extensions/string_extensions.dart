import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension PriceFormat on String {
  String get priceFormat => '$this رس';
}

extension HtmlTextExtractor on String {
  String htmlFormat() {
    RegExp htmlTagsRegExp = RegExp('<[^>]*>');
    return replaceAll(htmlTagsRegExp, '');
  }

  String displayDate() {
    final apiDate = DateFormat("yyyy-MM-dd").parse(this);
    final locale = Get.locale?.languageCode ?? 'ar';
    initializeDateFormatting(locale);
    return DateFormat("dd MMMM yyyy", locale).format(apiDate);
  }

  String replaceArabicNumbersWithRegular() {
    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩';
    const regularNumbers = '0123456789';

    final map = Map.fromIterables(arabicNumbers.runes, regularNumbers.runes);
    final replacedString = String.fromCharCodes(runes.map((rune) {
      return map[rune] ?? rune;
    }));

    return replacedString;
  }
}

extension DateFormatter on DateTime {
  String displayDate() {
    final locale = Get.locale?.languageCode ?? 'ar';
    initializeDateFormatting(locale);
    return DateFormat("dd MMMM yyyy", locale).format(this);
  }

  String toApiFormat() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
