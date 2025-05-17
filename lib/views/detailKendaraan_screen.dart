import 'package:crud_penyewaan/views/createPenyewaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:crud_penyewaan/models/kendaraan_model.dart';
import 'package:crud_penyewaan/services/kendaraan_service.dart';
import 'package:crud_penyewaan/views/editKendaraan_screen.dart';
import 'package:intl/intl.dart';

class DetailKendaraan extends StatefulWidget {
  const DetailKendaraan({super.key, required this.id_kendaraan});

  final String id_kendaraan;

  @override
  State<DetailKendaraan> createState() =>
      _DetailKendaraanState(id_kendaraan: id_kendaraan);
}

class _DetailKendaraanState extends State<DetailKendaraan> {
  final String id_kendaraan;

  _DetailKendaraanState({required this.id_kendaraan});
  final KendaraanService _kendaraanService = KendaraanService();
  KendaraanModel? kendaraan = KendaraanModel();

  @override
  void initState() {
    super.initState();
    fetchKendaraan();
  }

  Future<void> fetchKendaraan() async {
    kendaraan = await _kendaraanService.getKendaraanById(id_kendaraan);
    setState(() {});
  }

  Future<void> deleteKendaraan(String id) async {
    await _kendaraanService.deleteKendaraan(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Kendaraan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFB923C),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Image.network(
              kendaraan?.gambar ??
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/2019_Toyota_Corolla_Icon_Tech_VVT-i_Hybrid_1.8.jpg/960px-2019_Toyota_Corolla_Icon_Tech_VVT-i_Hybrid_1.8.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[500],
                  child: const Icon(Icons.car_crash),
                );
              },
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFFB923C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${kendaraan?.merk ?? "Unknown"} ${kendaraan?.nama ?? "-"}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp${NumberFormat("#,##0", "id_ID").format(kendaraan?.harga ?? 0)}/Hari',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Kapasitas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '${kendaraan?.kapasitas ?? "0"} orang',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.person, color: Colors.white),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  title: Column(
                                    children: [
                                      const Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.red,
                                        size: 48,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Delete data?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: const Text(
                                    'Apakah Anda yakin ingin menghapus data kendaraan ini?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                      ),
                                      child: const Text(
                                        'Ya',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () async {
                                        await deleteKendaraan(id_kendaraan);
                                        Navigator.of(context).pop();
                                        Navigator.pop(context, true);
                                      },
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Color(0xFF4CAF50),
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                      ),
                                      child: const Text(
                                        'Batal',
                                        style: TextStyle(
                                          color: Color(0xFF4CAF50),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Hapus',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => EditKendaraan(kendaraan: kendaraan),
                              ),
                            );
                            fetchKendaraan();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFABF1D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => CreatePenyewaan(
                                  id_kendaraan: kendaraan?.id ?? '0',
                                ),
                          ),
                        );
                        fetchKendaraan();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFABF1D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Sewa Kendaraan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
