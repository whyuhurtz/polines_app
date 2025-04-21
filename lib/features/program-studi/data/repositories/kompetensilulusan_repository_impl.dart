import 'dart:developer' as developer;
import 'package:polines_app/features/program-studi/domain/entities/kompetensilulusan_entity.dart';
import 'package:polines_app/features/program-studi/domain/repositories/kompetensilulusan_repository.dart';
import 'package:polines_app/features/program-studi/data/models/kompetensilulusan_model.dart';

class KompetensiLulusanRepositoryImpl implements KompetensiLulusanRepository {
  @override
  Future<KompetensiLulusan> getKompetensiLulusan() async {
    try {
      developer.log("Loading kompetensi lulusan data");
      
      // Simulate network request with a delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock data
      final Map<String, dynamic> jsonData = {
        "profil_lulusan": [
          {
            "title": "Kemampuan Administrasi Perkantoran",
            "content": "Mampu mengelola administrasi perkantoran, merancang/membuat/menangani system informasi surat masuk, surat keluar, kearsipan secara manual dan elektronik, system kearsipan, formulir aplikasi kantor dan bisnis, organisasi tata kerja, dokumen ekspor impor, menyusun laporan bisnis, memelihara dokumen dan sistem informasi."
          },
          {
            "title": "Komunikasi Bahasa Asing",
            "content": "Mampu berkomunikasi dalam bahasa asing(inggris, jepang/mandarin), public relation dan publisitas, notulen rapat, merancang/membuat skedul perjalan dinas, pimpinan."
          },
          {
            "title": "Penyusunan Laporan atau Dokumen Keuangan",
            "content": "Merancang dan melaksanakan rapat, konferensi, dan seminar; menyusun laporan keuangan sederhana, dokumen pajak."
          },
          {
            "title": "Pelayanan dan Tata Letak Kantor",
            "content": "Mendesain/mengidentifikasi prosedur perkantoran, pelayanan, tata letak kantor."
          },
          {
            "title": "Maintenance Alat-alat Perkantoran",
            "content": "Mengenal/mengoperasikan dan merawat alat-alat perkantoran manual dan elektronik dan mampu mengetik dengan kecepatan 60 kata permenit (bahasa Indonesia) dan 55 kata per menit (bahasa inggris) dengan akurasi 98%, komputer dan multimedia, faximile, scan, mesin cash register dan mesin hitung."
          }
        ]
      };

      developer.log("Creating model from JSON data");
      try {
        final result = KompetensiLulusanModel.fromJson(jsonData);
        developer.log("Successfully parsed kompetensi lulusan data");
        return result;
      } catch (parseError) {
        developer.log("Error parsing JSON data: $parseError", error: parseError);
        throw Exception("Failed to parse kompetensi lulusan data: $parseError");
      }
    } catch (e) {
      developer.log("Error loading kompetensi lulusan data: $e", error: e);
      throw Exception("Failed to load kompetensi lulusan data: $e");
    }
  }
}