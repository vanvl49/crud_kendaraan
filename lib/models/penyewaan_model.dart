import 'package:cloud_firestore/cloud_firestore.dart';

class PenyewaanModel {
  String? id;
  String? kendaraan_id;
  String? user_id;
  String? status;
  Timestamp? tanggal_mulai;
  Timestamp? tanggal_selesai;

  PenyewaanModel({
    this.id,
    this.kendaraan_id,
    this.user_id,
    this.status,
    this.tanggal_mulai,
    this.tanggal_selesai,
  });

  factory PenyewaanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PenyewaanModel(
      id: doc.id,
      kendaraan_id: data['kendaraan_id'] ?? 'no kendaraan_id',
      user_id: data['user_id'] ?? 'no user_id',
      status: data['status'] ?? 'no name',
      tanggal_mulai: data['tanggal_mulai'] ?? Timestamp.now(),
      tanggal_selesai: data['tanggal_selesai'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kendaraan_id': kendaraan_id,
      'user_id': user_id,
      'status': status,
      'tanggal_mulai' : tanggal_mulai,
      'tanggal_selesai' : tanggal_selesai
    };
  }
}
