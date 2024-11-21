class Disease {
  final int id;
  final String name;
  final String deskripsi;
  final String coverPage;
  final String createdAt;
  final String updatedAt;
  final int diseaseRecordsCount;

  Disease({
    required this.id,
    required this.name,
    required this.deskripsi,
    required this.coverPage,
    required this.createdAt,
    required this.updatedAt,
    required this.diseaseRecordsCount,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'],
      name: json['name'],
      deskripsi: json['deskripsi'],
      coverPage: json['cover_page'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      diseaseRecordsCount: json['disease_records_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'deskripsi': deskripsi,
      'cover_page': coverPage,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'disease_records_count': diseaseRecordsCount,
    };
  }
}
