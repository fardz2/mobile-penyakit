import 'package:heartrate_database_u_i/app/models/disease/record/record.dart';

class RecordResponse {
  final List<RecordDetail> records;
  final bool hasMorePages;

  RecordResponse({required this.records, required this.hasMorePages});

  factory RecordResponse.fromJson(Map<String, dynamic> json) {
    return RecordResponse(
      records: List<RecordDetail>.from(
        json['data']['records']
            .map((recordDetail) => RecordDetail.fromJson(recordDetail)),
      ),
      hasMorePages: json['data']["pagination"]['has_more_pages'],
    );
  }
}
