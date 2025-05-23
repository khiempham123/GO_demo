typedef Deserializer<T> = T Function(Map<String, dynamic> json);

Map? serializableToJson<T extends Serializable>(T? item) => item?.toJson();
List? serializableListToJson<T extends Serializable>(dynamic items) {
  if (items == null) return null;

  if (items is Iterable<T>) {
    return items.map((item) => item.toJson()).toList();
  }

  // ignore: avoid_dynamic_calls
  return [items?.toJson()];
}

String? stringFromJson(dynamic json) =>
    json is String ? json : json?.toString();
int? intFromJson(dynamic json) {
  if (json is int) return json;
  if (json is double) return json.toInt();
  if (json is String) return int.tryParse(json);

  return null;
}

double? doubleFromJson(dynamic json) {
  if (json is double) return json;
  if (json is int) return json.toDouble();
  if (json is String) return double.tryParse(json);

  return null;
}

abstract class Serializable {
  static const String kNullString = "__NULL__";
  static const int kNullInt = -2147483647;

  static final Map<String, Deserializer> _deserializers = {};
  Map<String, dynamic> toJson();

  const Serializable();

  static List<T>? fromList<T extends Serializable>(dynamic json) {
    if (json == null || json is! List) return null;
    return json
        .map((item) {
          try {
            return fromJson<T>(item);
          } catch (e) {
            return null;
          }
        })
        .where((element) => element != null)
        .cast<T>()
        .toList();
  }

  static T? fromJson<T>(Map<String, dynamic>? json) {
    if (json == null) return null;
    assert(
      _deserializers[T.toString()] != null,
      "${T.toString()} did not call Serializable.registerType()",
    );
    return _deserializers[T.toString()]!(json) as T;
  }

  static void registerType<T>(Deserializer deserializer) {
    _deserializers[T.toString()] = deserializer;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

extension DynamicExtension on dynamic {
  dynamic fromJson(value) {
    return value;
  }
}
