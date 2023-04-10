import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeStringConverter implements JsonConverter<DateTime, String> {
  const DateTimeStringConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}
