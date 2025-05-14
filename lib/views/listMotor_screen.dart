import 'package:crud_penyewaan/models/kendaraan_model.dart';
import 'package:crud_penyewaan/views/detailKendaraan_screen.dart';
import 'package:flutter/material.dart';
import 'package:crud_penyewaan/services/kendaraan_service.dart';
import 'package:crud_penyewaan/views/createKendaraan_screen.dart';
import 'listMobil_screen.dart';
import 'package:intl/intl.dart';

class ListMotor extends StatefulWidget {
  const ListMotor({super.key});

  @override
  State<ListMotor> createState() => _ListMotorState();
}

class _ListMotorState extends State<ListMotor> {
  final KendaraanService _kendaraanService = KendaraanService();
  List<KendaraanModel> motor = [];

  @override
  void initState() {
    super.initState();
    fetchMotor();
  }

  Future<void> fetchMotor() async {
    motor = await _kendaraanService.getMotor();
    // for (var car in motor) {
    //   print('Judul: ${book.title}, Deskripsi: ${book.description}');
    // }
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
                  builder: (_) => const CreateKendaraan(kategori: 'Motor'),
                ),
              );
              fetchMotor();
            },
            iconSize: 25,
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
                    child: IconButton(
                      onPressed: () async {
                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const ListMobil()),
                        );
                      },
                      icon: const Icon(
                        Icons.directions_car,
                        size: 25,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFFB923C), width: 2),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () async {},
                      icon: const Icon(
                        Icons.motorcycle,
                        size: 28,
                        color: Color(0xFFFB923C),
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
                    itemCount: motor.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final bike = motor[index];
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
                                bike.gambar ??
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
                                      '${bike.merk ?? "Unknown"} ${bike.nama ?? "motor"}',
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
                                          '${bike.kapasitas ?? "0"} orang',
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
                                          'Rp${NumberFormat("#,##0", "id_ID").format(bike.harga ?? 0)}/Hari',

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
                                                          bike.id ?? '0',
                                                    ),
                                              ),
                                            );
                                            fetchMotor();
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
