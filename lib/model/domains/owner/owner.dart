import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner.freezed.dart';
part 'owner.g.dart';

@freezed
class Owner with _$Owner {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Owner({
    required int id,
    required String login,
    required String avatarUrl,
    required String htmlUrl,
    String? name,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
