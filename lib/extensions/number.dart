import 'package:intl/intl.dart';

extension NumExtension on num {
  String format() {
    return NumberFormat('#,###.#').format(this);
  }
}
