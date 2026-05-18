import 'package:json_annotation/json_annotation.dart';

class FlexibleDoubleConverter implements JsonConverter<double, Object?> {
  const FlexibleDoubleConverter();

  @override
  double fromJson(Object? json) {
    if (json is num) {
      return json.toDouble();
    }
    if (json is String) {
      return double.tryParse(json) ?? 0;
    }

    return 0;
  }

  @override
  Object toJson(double object) => object;
}

class FlexibleNullableDoubleConverter
    implements JsonConverter<double?, Object?> {
  const FlexibleNullableDoubleConverter();

  @override
  double? fromJson(Object? json) {
    if (json == null) {
      return null;
    }
    if (json is num) {
      return json.toDouble();
    }
    if (json is String) {
      return double.tryParse(json);
    }

    return null;
  }

  @override
  Object? toJson(double? object) => object;
}

class FlexibleIntConverter implements JsonConverter<int, Object?> {
  const FlexibleIntConverter();

  @override
  int fromJson(Object? json) {
    if (json is int) {
      return json;
    }
    if (json is num) {
      return json.toInt();
    }
    if (json is String) {
      return int.tryParse(json) ?? 0;
    }

    return 0;
  }

  @override
  Object toJson(int object) => object;
}

class FlexibleNullableIntConverter implements JsonConverter<int?, Object?> {
  const FlexibleNullableIntConverter();

  @override
  int? fromJson(Object? json) {
    if (json == null) {
      return null;
    }
    if (json is int) {
      return json;
    }
    if (json is num) {
      return json.toInt();
    }
    if (json is String) {
      return int.tryParse(json);
    }

    return null;
  }

  @override
  Object? toJson(int? object) => object;
}
