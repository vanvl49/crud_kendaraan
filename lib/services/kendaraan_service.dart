import 'package:crud_penyewaan/models/kendaraan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KendaraanService {
  final CollectionReference kendaraanRef = FirebaseFirestore.instance
      .collection('kendaraan');

  Future<void> createKendaraan(KendaraanModel kendaraan) async {
    try {
      final docRef = kendaraanRef.add(kendaraan.toJson());
      final docSnapshot = await docRef;
      kendaraan.id = docSnapshot.id;
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<KendaraanModel>> getKendaraan() async {
    try {
      final snapshot = await kendaraanRef.get();
      if (snapshot.docs.isEmpty) {
        print("Data kendaraan tidak ditemukan.");
      }
      return snapshot.docs.map((doc) {
        return KendaraanModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<KendaraanModel?> getKendaraanById(String id) async {
    final doc = await kendaraanRef.doc(id).get();
    if (doc.exists) {
      return KendaraanModel.fromFirestore(doc);
    }
    return null;
  }

  Future<List<KendaraanModel>> getMobil() async {
    try {
      final snapshot =
          await kendaraanRef.where('kategori', isEqualTo: 'Mobil').get();
      if (snapshot.docs.isEmpty) {
        print("Data mobil tidak ditemukan.");
      }
      return snapshot.docs.map((doc) {
        return KendaraanModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<KendaraanModel>> getMotor() async {
    try {
      final snapshot =
          await kendaraanRef.where('kategori', isEqualTo: 'Motor').get();
      if (snapshot.docs.isEmpty) {
        print("Data mobil tidak ditemukan.");
      }
      return snapshot.docs.map((doc) {
        return KendaraanModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<void> updateKendaraan(KendaraanModel kendaraan) async {
    if (kendaraan.id == null) return;
    await kendaraanRef.doc(kendaraan.id).update(kendaraan.toJson());
  }

  Future<void> deleteKendaraan(String id) async {
    await kendaraanRef.doc(id).delete();
  }
}
