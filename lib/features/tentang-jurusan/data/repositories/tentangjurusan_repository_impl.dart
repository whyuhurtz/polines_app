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
      
      // Menggunakan Map untuk menghindari masalah escape karakter di string JSON
      final Map<String, dynamic> jsonData = {
        "tentang": "Lembaga Pendidikan ini didirikan atas dasar langkanya tenaga teknisi ahli madya yang diperlukan oleh industri dan keberhasilan Politeknik mekanik Swiss dan ITB, yang didirikan pada tahun 1976. Untuk itu tahun 1982 telah dioperasikan 6 buah Politeknik di USU Medan, UNSRI Palembang, UI Jakarta, ITB Bandung, UNDIP Semarang, dan UNIBRAW Malang dengan bantuan Bank Dunia sesuai dengan surat keputusan Direktorat Jenderal Pendidikan Tinggi Nomor 03/Dj/Kep/1979.\n\nPoliteknik Universitas Diponegoro pada awal mulanya (1982) mempunyai tiga departemen/jurusan bidang keteknikan, yaitu, Departemen/Jurusan Teknik Sipil, Departemen/Jurusan Teknik Mesin, dan Departemen /Jurusan Teknik Elektro. Tahun 1985 dibuka Jurusan Tata Niaga karena kebutuhan industri menuntut adanya tenaga terampil di bidang bisnis. Pada tahun 1989 terjadi pengembangan jurusan Elektro menjadi Jurusan Teknik Listrik dan Jurusan Teknik Elektronika/Telekomunikasi.\n\nBerdasarkan Surat Keputusan Menteri Pendidikan dan Kebudayaan RI No. : 313/O/1991 tanggal 6 Juni 1991 tentang Penataan Politeknik dalam lingkungan Universitas dan Institut Negeri maka pada tahun 1992 mempunyai 5 jurusan yaitu : Teknik Sipil, Teknik Mesin, Teknik Elektro, Akuntansi dan Administrasi Bisnis.\n\nPada tanggal 6 Agustus tahun 1997 Politeknik Universitas Diponegoro dinyatakan mandiri dan lepas dari manajemen Universitas Diponegoro dengan Surat Keputusan Menteri Pendidikan dan Kebudayaan RI Nomor : 175/O/1997 dengan nama POLITEKNIK NEGERI SEMARANG. Kemudian pada tanggal 31 Juli 2002 terbit surat keputusan Menteri Pendidikan Nasional nomor 134/O/2002 mengatur tentang Organisasi dan Tata Kerja Politeknik Negeri Semarang.",
        "visi": "Politeknik Negeri Semarang menjadi perguruan tinggi yang memajukan kemandirian teknologi dan bisnis bangsa Indonesia serta peradaban dunia.",
        "misi": {
          "1": "Towards quality education: Melaksanakan pendidikan tinggi bidang teknologi dan bisnis yang unggul, berkarakter dan berorientasi kewirausahaan.",
          "2": "Techno-preneur research: Melaksanakan penelitian terapan bidang teknologi dan bisnis serta penerapan teknologi masa depan secara keekonomian.",
          "3": "Smart society: Mengembangkan budaya masyarakat cerdas berpengetahuan melalui pemasyarakatan techno-preneur dan kerjasama.",
          "4": "Good governance: Meningkatkan kualitas manajemen institusi melalui perbaikan berkelanjutan berdasarkan prinsip tata kelola yang baik."
        }
      };
      
      developer.log("Creating model from JSON data");
      try {
        final result = TentangJurusanModel.fromJson(jsonData);
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