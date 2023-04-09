import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory User({
    required String login,
    required String avatarUrl,
    required String htmlUrl,
    String? name,
    String? bio,
    required int followers,
    required int following,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
