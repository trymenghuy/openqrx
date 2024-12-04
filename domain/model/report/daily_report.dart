// ignore_for_file: public_member_api_docs, sort_constructors_first
// class DailyReport {
//   final Map<String, int> product;
// }
// class DailyReport {
//   final Map<String, DailyReportData> data;
//   DailyReport({
//     required this.data,
//   });

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'data': data.map((key, value) => MapEntry(key, value.toJson())),
//     };
//   }

//   factory DailyReport.fromJson(Map<String, dynamic> map) {
//     return DailyReport(
//       data: (map['data'] as Map<String, dynamic>)
//           .map((key, value) => MapEntry(key, DailyReportData.fromJson(value))),
//     );
//   }
// }

class DailyReport {
  final Map<String, int> product;
  final int total;
  final String dayId;
  DailyReport({
    required this.product,
    required this.total,
    required this.dayId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'product': product,
      'total': total,
      'dayId': dayId,
    };
  }

  factory DailyReport.fromJson(Map<String, dynamic> map) {
    return DailyReport(
      product: Map<String, int>.from((map['product'] as Map<String, int>)),
      total: map['total'] as int,
      dayId: map['dayId'] as String,
    );
  }
}
