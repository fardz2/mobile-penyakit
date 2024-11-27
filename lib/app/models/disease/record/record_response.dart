class RecordResponse {
  final List<RecordDetail> records;
  final bool hasMorePages;
  final List<Schema> schema;
  final String exportUrl;

  RecordResponse({
    required this.records,
    required this.hasMorePages,
    required this.schema,
    required this.exportUrl,
  });

  factory RecordResponse.fromJson(Map<String, dynamic> json) {
    return RecordResponse(
      records: List<RecordDetail>.from(
        json['data']['records']
            .map((recordDetail) => RecordDetail.fromJson(recordDetail)),
      ),
      hasMorePages: json['data']['pagination']['has_more_pages'],
      schema: List<Schema>.from(
        json['data']['schema'].map((schema) => Schema.fromJson(schema)),
      ),
      exportUrl: json['data']['export_url'] ?? '',
    );
  }
}

class RecordResponseDetail {
  final RecordDetail records;
  final List<Schema> schema;

  RecordResponseDetail({
    required this.records,
    required this.schema,
  });

  factory RecordResponseDetail.fromJson(Map<String, dynamic> json) {
    return RecordResponseDetail(
      records: RecordDetail.fromJson(json['data']['record']),
      schema: List<Schema>.from(
        json['data']['schema'].map((schema) => Schema.fromJson(schema)),
      ),
    );
  }
}

class RecordDetail {
  final int id;
  final int diseaseId;
  final Map<String, dynamic> fields; // Menyimpan data dinamis
  final String createdAt;
  final String updatedAt;
  final String exportUrl;

  RecordDetail({
    required this.id,
    required this.diseaseId,
    required this.fields,
    required this.createdAt,
    required this.updatedAt,
    required this.exportUrl,
  });

  factory RecordDetail.fromJson(Map<String, dynamic> json) {
    return RecordDetail(
      id: json['id'],
      diseaseId: json['disease_id'],
      fields: Map<String, dynamic>.from(json['data']), // Data dinamis
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      exportUrl: json['export_url'],
    );
  }

  // Mengakses data dari fields dengan validasi tipe berdasarkan schema
  dynamic getField(String fieldName, Schema schema) {
    var value = fields[fieldName];
    if (value == null) return null;

    switch (schema.type) {
      case 'integer':
        return int.tryParse(value.toString()) ?? value;
      case 'decimal':
        return double.tryParse(value.toString()) ?? value;
      case 'date':
      case 'datetime':
        return DateTime.tryParse(value.toString());
      case 'file':
        return value; // URL file
      default:
        return value; // String atau lainnya
    }
  }
}

class Schema {
  final String name;
  final String type;
  final bool isVisible;
  final String? format; // Format opsional (misalnya: audio, video)
  final bool multiple; // Menentukan apakah data bisa banyak file

  Schema({
    required this.name,
    required this.type,
    required this.isVisible,
    this.format,
    this.multiple = false,
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
    return Schema(
      name: json['name'],
      type: json['type'],
      isVisible: json['is_visible'],
      format: json['format'],
      multiple: json['multiple'] ?? false,
    );
  }
}
