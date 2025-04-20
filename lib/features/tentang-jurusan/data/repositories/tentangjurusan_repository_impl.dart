import 'dart:convert';
import 'dart:developer' as developer;

import 'package:polines_app/features/tentang-jurusan/data/models/tentangjurusan_model.dart';
import 'package:polines_app/features/tentang-jurusan/domain/entities/tentangjurusan_entity.dart';
import 'package:polines_app/features/tentang-jurusan/domain/repositories/tentangjurusan_repository.dart';

class TentangJurusanRepositoryImpl implements TentangJurusanRepository {
  @override
  Future<TentangJurusan> getTentangJurusan() async {
    try {
      developer.log("Loading tentang jurusan data");
      
      // Simulate network request with a delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // For now, return mock data
      // In a real app, this would come from an API or local database
      final String jsonString = '''
      {
        "tentang": "Lembaga Pendidikan ini didirikan atas dasar langkanya tenaga teknisi ahli madya yang diperlukan oleh industri dan keberhasilan Politeknik mekanik Swiss dan ITB. Politeknik Negeri Semarang merupakan Pendidikan Profesional dalam sejumlah bidang pengetahuan khusus. Politeknik Negeri Semarang yang disingkat dengan Polines merupakan Perguruan Tinggi di lingkungan Kementerian Riset, Teknologi dan Pendidikan Tinggi yang dipimpin oleh seorang Direktur yang berada di bawah dan bertanggungjawab kepada Menteri Riset, Teknologi dan Pendidikan Tinggi melalui rektor Universitas Diponegoro. Polines beralamat di Jalan Prof. Sudarto, SH, Tembalang, Semarang.",
        "visi": "Politeknik Negeri Semarang menjadi perguruan tinggi yang memajukan kemandirian teknologi dan bisnis bangsa Indonesia serta peradaban dunia.",
        "misi": {
          "1": "Towards quality education: Melaksanakan pendidikan tinggi bidang teknologi dan bisnis yang unggul, berkarakter dan berorientasi kewirausahaan.",
          "2": "Techno-preneur research: Melaksanakan penelitian terapan bidang teknologi dan bisnis serta penerapan teknologi masa depan secara keekonomian.",
          "3": "Smart society: Mengembangkan budaya masyarakat cerdas berpengetahuan melalui pemasyarakatan techno-preneur dan kerjasama.",
          "4": "Good governance: Meningkatkan kualitas manajemen institusi melalui perbaikan berkelanjutan berdasarkan prinsip tata kelola yang baik."
        }
      }
      ''';
      
      developer.log("Parsing JSON data");
      try {
        final Map<String, dynamic> mockJson = jsonDecode(jsonString);
        final result = TentangJurusanModel.fromJson(mockJson);
        developer.log("Successfully parsed tentang jurusan data");
        return result;
      } catch (parseError) {
        developer.log("Error parsing JSON data: $parseError", error: parseError);
        throw Exception("Failed to parse tentang jurusan data: $parseError");
      }
    } catch (e) {
      developer.log("Error loading tentang jurusan data: $e", error: e);
      throw Exception("Failed to load tentang jurusan data: $e");
    }
  }
}