// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntities _$UserEntitiesFromJson(Map<String, dynamic> json) => UserEntities(
  id: json['id'] as String?,
  email: json['email'] as String?,
  isEmailVerified: json['isEmailVerified'] as bool?,
  isSubscribed: json['isSubscribed'] as bool?,
  savedLocations:
      (json['savedLocations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  preferredTemperatureUnit: json['preferredTemperatureUnit'] as String?,
);

Map<String, dynamic> _$UserEntitiesToJson(UserEntities instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'isEmailVerified': instance.isEmailVerified,
      'isSubscribed': instance.isSubscribed,
      'savedLocations': instance.savedLocations,
      'preferredTemperatureUnit': instance.preferredTemperatureUnit,
    };
