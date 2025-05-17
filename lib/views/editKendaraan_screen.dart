import 'package:crud_penyewaan/models/kendaraan_model.dart';
import 'package:crud_penyewaan/views/listMotor_screen.dart';
import 'package:flutter/material.dart';
import 'package:crud_penyewaan/services/kendaraan_service.dart';
import 'package:intl/intl.dart';

class EditKendaraan extends StatefulWidget {
  const EditKendaraan({super.key, required this.kendaraan});
  final KendaraanModel? kendaraan;

  @override
  State<EditKendaraan> createState() => _EditKendaraanState();
}

class _EditKendaraanState extends State<EditKendaraan> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController merkController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kapasitasController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController gambarController = TextEditingController();
  final KendaraanService _kendaraanService = KendaraanService();
  String selectedKategori = 'Mobil';

  @override
  void initState() {
    super.initState();
    if (widget.kendaraan != null) {
      selectedKategori = widget.kendaraan!.kategori ?? 'Mobil';
      kategoriController.text = widget.kendaraan!.kategori ?? '';
      merkController.text = widget.kendaraan!.merk ?? '';
      namaController.text = widget.kendaraan!.nama ?? '';
      kapasitasController.text = widget.kendaraan!.kapasitas?.toString() ?? '';
      hargaController.text = widget.kendaraan!.harga?.toString() ?? '';
      gambarController.text = widget.kendaraan!.gambar ?? '';
    }
  }

  Future<void> saveKendaraan() async {
    if (_formKey.currentState!.validate()) {
      final kendaraan = KendaraanModel(
        id: widget.kendaraan?.id,
        kategori: selectedKategori,
        merk: merkController.text.trim(),
        nama: namaController.text.trim(),
        kapasitas: int.parse(kapasitasController.text.trim()),
        harga: int.parse(hargaController.text.trim()),
        gambar: gambarController.text.trim(),
      );
      await _kendaraanService.updateKendaraan(kendaraan);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Data Kendaraan',
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
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                  setState(() {
                    selectedKategori = newValue!;
                    kategoriController.text = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: merkController,
                decoration: const InputDecoration(
                  labelText: 'Merk',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Merk wajib diisi'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kendaraan',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Nama kendaraan wajib diisi'
                            : null,
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
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Kapasitas wajib diisi'
                            : null,
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
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Harga wajib diisi'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: gambarController,
                decoration: const InputDecoration(
                  labelText: 'URL Gambar',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'URL gambar wajib diisi'
                            : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: saveKendaraan,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Color(0xFFFB923C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Ubah',
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
