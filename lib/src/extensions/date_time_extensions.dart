import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  static DateTime get today => DateTime.now().toDate();
  DateTime get tomorrow => DateTime.now().add(Duration(days: 1)).toDate();
  DateTime get yesterday => DateTime.now().subtract(Duration(days: 1)).toDate();

  DateTime toDate() => DateTime(this.year, this.month, this.day);

  String toDisplayValue() {
    DateTime now = DateTime.now();

    if (this.toDate() == now.toDate()) {
      return 'Vandaag';
    }

    if (this.toDate() == now.yesterday) {
      return 'Gisteren';
    }

    if (this.toDate() == now.tomorrow) {
      return 'Morgen';
    }

    return DateFormat('dd-MM-yyyy').format(this);
  }
}
