import 'package:cloud_firestore/cloud_firestore.dart';

class KendaraanModel {
  String? id;
  String? kategori;
  String? merk;
  String? nama;
  int? kapasitas;
  int? harga;
  String? gambar;

  KendaraanModel({
    this.id,
    this.kategori,
    this.merk,
    this.nama,
    this.harga,
    this.kapasitas,
    this.gambar,
  });

  factory KendaraanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return KendaraanModel(
      id: doc.id,
      kategori: data['kategori'] ?? 'no kategori',
      merk: data['merk'] ?? 'no merk',
      nama: data['nama'] ?? 'no name',
      kapasitas: int.tryParse(data['kapasitas'].toString()) ?? 0,
      harga: int.tryParse(data['harga'].toString()) ?? 0,
      gambar: data['gambar'] ?? 'no image',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kategori': kategori,
      'merk': merk,
      'nama': nama,
      'kapasitas': kapasitas,
      'harga': harga,
      'gambar': gambar,
    };
  }
}
