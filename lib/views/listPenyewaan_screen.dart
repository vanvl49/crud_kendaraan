import 'package:flutter/material.dart';
import 'package:crud_penyewaan/models/penyewaan_model.dart';
import 'package:crud_penyewaan/services/penyewaan_service.dart';
import 'package:crud_penyewaan/services/users_service.dart';
import 'package:crud_penyewaan/views/listMobil_screen.dart';
import 'package:crud_penyewaan/services/kendaraan_service.dart';
import 'package:crud_penyewaan/models/kendaraan_model.dart';
import 'package:crud_penyewaan/models/users_model.dart';

class PenyewaanView extends StatefulWidget {
  const PenyewaanView({super.key});

  @override
  State<PenyewaanView> createState() => _PenyewaanViewState();
}

class _PenyewaanViewState extends State<PenyewaanView> {
  final penyewaanService = PenyewaanService();
  final usersService = UsersService();
  final kendaraanService = KendaraanService();

  Future<List<Map<String, dynamic>>> fetchPenyewaanWithDetails() async {
    List<PenyewaanModel> penyewaanList = await penyewaanService.getpenyewaan();

    List<Map<String, dynamic>> detailedList = [];

    for (var item in penyewaanList) {
      UsersModel? user = await usersService.getusersById(item.user_id ?? "");
      KendaraanModel? kendaraan = await kendaraanService.getKendaraanById(
        item.kendaraan_id ?? "",
      );

      detailedList.add({
        'penyewaan': item,
        'user': user,
        'foto_kendaraan': kendaraan,
      });
    }

    return detailedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFFFB923C),
        title: const Text(
          'Daftar Penyewaan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchPenyewaanWithDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada data penyewaan."));
          }

          final dataList = snapshot.data!;

          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              final penyewaan = item['penyewaan'] as PenyewaanModel;
              final user = item['user'] as UsersModel?;
              final kendaraan = item['foto_kendaraan'] as KendaraanModel?;
              final fotoKendaraanUrl =
                  kendaraan?.gambar ?? 'https://via.placeholder.com/60';

              return Card(
                elevation: 3,
                color: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          fotoKendaraanUrl,
                          width: 100,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 70,
                              color: Colors.grey[500],
                              child: const Icon(
                                Icons.car_crash,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Penyewa: ${user?.name ?? 'Nama tidak tersedia'}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Tanggal: ${penyewaan.tanggal_mulai?.toDate().toString().substring(0, 10)} - ${penyewaan.tanggal_selesai?.toDate().toString().substring(0, 10)}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  penyewaan.status ?? '-',
                                  style: const TextStyle(
                                    color: Color(0xFFFB923C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xFFFB923C),
        ),
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ListMobil()),
                  );
                },
                icon: const Icon(
                  Icons.car_crash,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: const Icon(
                  Icons.home,
                  size: 35,
                  color: Color(0xFFFB923C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
