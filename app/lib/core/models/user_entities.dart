import 'package:json_annotation/json_annotation.dart';

part 'user_entities.g.dart';

@JsonSerializable()
class UserEntities {
  final String? id;
  final String? email;
  final bool? isEmailVerified;
  final bool? isSubscribed;
  final List<String>? savedLocations;
  final String? preferredTemperatureUnit; // 'celsius' or 'fahrenheit'

  UserEntities({
    this.id,
    this.email,
    this.isEmailVerified,
    this.isSubscribed,
    this.savedLocations,
    this.preferredTemperatureUnit,
  });

  factory UserEntities.fromJson(Map<String, dynamic> json) =>
      _$UserEntitiesFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntitiesToJson(this);
}
