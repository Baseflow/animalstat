import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  static DateTime get today => DateTime.now().toDate();
  DateTime get tomorrow => DateTime.now().add(const Duration(days: 1)).toDate();
  DateTime get yesterday =>
      DateTime.now().subtract(const Duration(days: 1)).toDate();

  DateTime toDate() => DateTime(year, month, day);

  String toDisplayValue() {
    var now = DateTime.now();

    if (toDate() == now.toDate()) {
      return 'Vandaag';
    }

    if (toDate() == now.yesterday) {
      return 'Gisteren';
    }

    if (toDate() == now.tomorrow) {
      return 'Morgen';
    }

    return DateFormat('dd-MM-yyyy').format(this);
  }
}
