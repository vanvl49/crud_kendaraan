import 'package:crud_penyewaan/models/penyewaan_model.dart';
import 'package:crud_penyewaan/services/penyewaan_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePenyewaan extends StatefulWidget {
  const CreatePenyewaan({super.key, required this.id_kendaraan});
  final String id_kendaraan;

  @override
  State<CreatePenyewaan> createState() =>
      _CreatePenyewaanState(id_kendaraan: id_kendaraan);
}

class _CreatePenyewaanState extends State<CreatePenyewaan> {
  final _formKey = GlobalKey<FormState>();
  final String id_kendaraan;

  _CreatePenyewaanState({required this.id_kendaraan});

  final TextEditingController tanggalMulaiController = TextEditingController();
  final TextEditingController tanggalSelesaiController =
      TextEditingController();

  final PenyewaanService _penyewaanService = PenyewaanService();

  Future<void> _selectTanggalMulai(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        tanggalMulaiController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTanggalSelesai(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final mulaiText = tanggalMulaiController.text;
      if (mulaiText.isNotEmpty) {
        final mulai = DateFormat('yyyy-MM-dd').parse(mulaiText);
        if (picked.isBefore(mulai)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Tanggal selesai tidak boleh sebelum tanggal mulai',
              ),
              backgroundColor: Colors.red,
            ),
          );
          return; // Jangan lanjutkan jika tidak valid
        }
      }

      setState(() {
        tanggalSelesaiController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> savePenyewaan() async {
    final penyewaan = PenyewaanModel(
      kendaraan_id: id_kendaraan,
      user_id: "1",
      status: 'pending',
      tanggal_mulai: Timestamp.fromDate(
        DateFormat('yyyy-MM-dd').parse(tanggalMulaiController.text),
      ),
      tanggal_selesai: Timestamp.fromDate(
        DateFormat('yyyy-MM-dd').parse(tanggalSelesaiController.text),
      ),
    );
    await _penyewaanService.createPenyewaan(penyewaan);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Penyewaan',
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
              TextFormField(
                controller: tanggalMulaiController,
                readOnly: true,
                onTap: () => _selectTanggalMulai(context),
                decoration: InputDecoration(
                  labelText: 'Tanggal Mulai',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal mulai wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: tanggalSelesaiController,
                readOnly: true,
                onTap: () => _selectTanggalSelesai(context),
                decoration: InputDecoration(
                  labelText: 'Tanggal Selesai',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal selesai wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    savePenyewaan();
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
                  'Tambah Penyewaan',
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
