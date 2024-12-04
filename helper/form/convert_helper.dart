import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:openqrx/app/service/date_service.dart';

class ConvertHelper {
  static DateTime? otherToDate(dynamic value) {
    if (value is DateTime) {
      return value;
    } else if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateService.instance.dayToDate(value);
    }
    return null;
  }

  static Timestamp? otherToTimeStamp(dynamic value) {
    if (value is DateTime) {
      return Timestamp.fromDate(value);
    } else if (value is int) {
      return Timestamp.fromMillisecondsSinceEpoch(value);
    } else if (value is Timestamp) {
      return value;
    }
    return null;
  }

  static String otherToString(dynamic value) {
    if (value == null || value == 0) return '';
    if (value is List) {
      return value.join(', ');
    } else if (value is num) {
      return value.toString();
    } else if (value is DateTime) {
      return DateService.instance.dateToFullDay(value);
    }
    return value;
  }

  static Map<String, T> convertSummaryValues<T>(String key,
      Map<String, dynamic> map, T Function(Map<String, dynamic>) converter) {
    if (map.containsKey(key) && map[key] is Map<String, dynamic>) {
      return {
        key: (map[key] as Map<String, dynamic>).map((innerKey, value) =>
            MapEntry(innerKey, converter(value as Map<String, dynamic>)))
      } as Map<String, T>;
    } else {
      throw ArgumentError(
          "The provided map does not contain the specified key or the value is not a Map<String, dynamic>.");
    }
  }
}
