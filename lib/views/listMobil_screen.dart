import 'package:crud_penyewaan/models/kendaraan_model.dart';
import 'package:crud_penyewaan/views/listMotor_screen.dart';
import 'package:crud_penyewaan/views/detailKendaraan_screen.dart';
import 'package:crud_penyewaan/views/createKendaraan_screen.dart';
import 'package:flutter/material.dart';
import 'package:crud_penyewaan/services/kendaraan_service.dart';
import 'package:intl/intl.dart';

class ListMobil extends StatefulWidget {
  const ListMobil({super.key});

  @override
  State<ListMobil> createState() => _ListMobilState();
}

class _ListMobilState extends State<ListMobil> {
  final KendaraanService _kendaraanService = KendaraanService();
  List<KendaraanModel> mobil = [];

  @override
  void initState() {
    super.initState();
    fetchMobil();
  }

  Future<void> fetchMobil() async {
    mobil = await _kendaraanService.getMobil();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFFFB923C),
        title: const Text(
          'Daftar Kendaraan Sewa',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            color: Colors.white,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateKendaraan(kategori: 'Mobil'),
                ),
              );
              fetchMobil();
            },
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFFB923C), width: 2),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.directions_car,
                        size: 28,
                        color: Color(0xFFFB923C),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () async {
                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const ListMotor()),
                        );
                      },
                      icon: const Icon(
                        Icons.motorcycle,
                        size: 25,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),

                  ListView.builder(
                    itemCount: mobil.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final car = mobil[index];
                      return Card(
                        elevation: 3,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Image.network(
                                car.gambar ??
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/2019_Toyota_Corolla_Icon_Tech_VVT-i_Hybrid_1.8.jpg/960px-2019_Toyota_Corolla_Icon_Tech_VVT-i_Hybrid_1.8.jpg',
                                width: 100,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 70,
                                    color: Colors.grey[500],
                                    child: const Icon(Icons.car_crash),
                                  );
                                },
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${car.merk ?? "Unknown"} ${car.nama ?? "mobil"}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '${car.kapasitas ?? "0"} orang',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rp${NumberFormat("#,##0", "id_ID").format(car.harga ?? 0)}/Hari',

                                          style: TextStyle(
                                            color: Color(0xFFFB923C),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => DetailKendaraan(
                                                      id_kendaraan:
                                                          car.id ?? 'o',
                                                    ),
                                              ),
                                            );
                                            fetchMobil();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFFB923C),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: Container(
      //   decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20),
      //       topRight: Radius.circular(20),
      //     ),
      //     color: Color(0xFFFB923C),
      //   ),
      //   height: 80,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Container(
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(12),
      //           ),
      //           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      //           child: const Icon(
      //             Icons.car_crash,
      //             size: 35,
      //             color: Color(0xFFFB923C),
      //           ),
      //         ),
      //         IconButton(
      //           onPressed: () {},
      //           icon: const Icon(Icons.home, size: 30, color: Colors.white),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
