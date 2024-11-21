class RecordDetail {
  final int? id;
  final int? diseaseId;
  final RecordData? data;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RecordDetail({
    this.id,
    this.diseaseId,
    this.data,
    this.createdAt,
    this.updatedAt,
  });

  // Method untuk menginisialisasi dari JSON
  factory RecordDetail.fromJson(Map<String, dynamic> json) {
    return RecordDetail(
      id: json['id'],
      diseaseId: json['disease_id'],
      data: json['data'] != null ? RecordData.fromJson(json['data']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Method untuk mengubah ke Map (biasanya digunakan untuk mengirim data ke API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'disease_id': diseaseId,
      'data': data?.toJson(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class RecordData {
  final String? jenis;
  final dynamic? durasi;
  final String? record;
  final String? signals;
  final String? annotations;
  final String? tanggalTes;
  final String? fileDetakJantung;

  RecordData({
    this.jenis,
    this.durasi,
    this.record,
    this.signals,
    this.annotations,
    this.tanggalTes,
    this.fileDetakJantung,
  });

  // Method untuk menginisialisasi dari JSON
  factory RecordData.fromJson(Map<String, dynamic> json) {
    return RecordData(
      jenis: json['jenis'],
      durasi: json['durasi'],
      record: json['record'],
      signals: json['signals'],
      annotations: json['annotations'],
      tanggalTes: json['tanggal_tes'],
      fileDetakJantung: json['file_detak_jantung'],
    );
  }

  // Method untuk mengubah ke Map (biasanya digunakan untuk mengirim data ke API)
  Map<String, dynamic> toJson() {
    return {
      'jenis': jenis,
      'durasi': durasi,
      'record': record,
      'signals': signals,
      'annotations': annotations,
      'tanggal_tes': tanggalTes,
      'file_detak_jantung': fileDetakJantung,
    };
  }
}
