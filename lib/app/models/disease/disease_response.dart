import 'package:heartrate_database_u_i/app/models/disease/disease.dart';

class DiseaseResponse {
  final List<Disease> diseases;
  final bool hasMorePages;

  DiseaseResponse({required this.diseases, required this.hasMorePages});

  factory DiseaseResponse.fromJson(Map<String, dynamic> json) {
    return DiseaseResponse(
      diseases: List<Disease>.from(
        json['data']['diseases'].map((disease) => Disease.fromJson(disease)),
      ),
      hasMorePages: json['data']["pagination"]['has_more_pages'],
    );
  }
}
