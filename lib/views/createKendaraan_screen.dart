import 'package:crud_penyewaan/models/kendaraan_model.dart';
import 'package:crud_penyewaan/views/listMotor_screen.dart';
import 'package:flutter/material.dart';
import 'package:crud_penyewaan/services/kendaraan_service.dart';
import 'package:intl/intl.dart';

class CreateKendaraan extends StatefulWidget {
  const CreateKendaraan({super.key, required this.kategori});
  final String kategori;

  @override
  State<CreateKendaraan> createState() =>
      _CreateKendaraanState(selectedKategori: kategori);
}

class _CreateKendaraanState extends State<CreateKendaraan> {
  final _formKey = GlobalKey<FormState>();

  String selectedKategori;
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController merkController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kapasitasController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final KendaraanService _kendaraanService = KendaraanService();

  _CreateKendaraanState({required this.selectedKategori}) {
    kategoriController.text = selectedKategori;
  }

  Future<void> saveKendaraan() async {
    final kendaraan = KendaraanModel(
      kategori: selectedKategori,
      merk: merkController.text.trim(),
      nama: namaController.text.trim(),
      kapasitas: int.parse(kapasitasController.text.trim()),
      harga: int.parse(hargaController.text.trim()),
      gambar: gambarController.text.trim(),
    );
    await _kendaraanService.createKendaraan(kendaraan);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Data Kendaraan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFB923C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // ini penting!
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ... Dropdown tetap bisa seperti biasa
              DropdownButtonFormField<String>(
                value: selectedKategori,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Mobil', child: Text('Mobil')),
                  DropdownMenuItem(value: 'Motor', child: Text('Motor')),
                ],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedKategori = newValue;
                      kategoriController.text = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // 👇 Ganti TextField jadi TextFormField dan tambahkan validator
              TextFormField(
                controller: merkController,
                decoration: const InputDecoration(
                  labelText: 'Merk',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Merk wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kendaraan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama kendaraan wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: kapasitasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Kapasitas Penumpang',
                  border: OutlineInputBorder(),
                  suffixText: 'orang',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kapasitas wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga Sewa per Hari',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: gambarController,
                decoration: const InputDecoration(
                  labelText: 'URL Gambar',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'URL gambar wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveKendaraan(); // hanya disimpan jika semua field valid
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Color(0xFFFB923C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Simpan Kendaraan',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
