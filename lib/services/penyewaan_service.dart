import 'package:crud_penyewaan/models/penyewaan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_penyewaan/models/penyewaan_model.dart';

class PenyewaanService {
  final CollectionReference penyewaanRef = FirebaseFirestore.instance
      .collection('penyewaan');

  Future<void> createPenyewaan(PenyewaanModel penyewaan) async {
    try {
      final docRef = penyewaanRef.add(penyewaan.toJson());
      final docSnapshot = await docRef;
      penyewaan.id = docSnapshot.id;
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<PenyewaanModel>> getpenyewaan() async {
    try {
      final snapshot = await penyewaanRef.get();
      if (snapshot.docs.isEmpty) {
        print("Data penyewaan tidak ditemukan.");
      }
      return snapshot.docs.map((doc) {
        return PenyewaanModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<PenyewaanModel?> getpenyewaanById(String id) async {
    final doc = await penyewaanRef.doc(id).get();
    if (doc.exists) {
      return PenyewaanModel.fromFirestore(doc);
    }
    return null;
  }

  Future<void> updatepenyewaan(PenyewaanModel penyewaan) async {
    if (penyewaan.id == null) return;
    await penyewaanRef.doc(penyewaan.id).update(penyewaan.toJson());
  }

  Future<void> deletepenyewaan(String id) async {
    await penyewaanRef.doc(id).delete();
  }
}
