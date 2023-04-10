import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String yMd({bool addHm = false}) {
    final format = DateFormat.yMd();

    if (!addHm) {
      return format.format(this);
    }

    return format.add_Hm().format(this);
  }
}
