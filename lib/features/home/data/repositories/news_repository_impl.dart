import 'dart:developer' as developer;
import 'package:polines_app/features/home/data/models/news_model.dart';
import 'package:polines_app/features/home/domain/entities/news_entity.dart';
import 'package:polines_app/features/home/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  // Menggunakan List<Map> alih-alih string JSON untuk menghindari masalah parsing
  final List<Map<String, dynamic>> _sampleNewsData = [
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "10:42",
      "title": "IMPLEMENTASI GKM UNTUK MENDUKUNG STANDARISASI MUTU PROGRAM STUDI DAN JURUSAN ADMINISTRASI 2024",
      "content": "Jurusan Administrasi Bisnis (AB) Politeknik Negeri Semarang (Polines) hingga tahun 2021 mempunyai 4 (empat) Program Studi, yaitu Program Studi Administrasi Bisnis (D3-AB), Manajemen Pemasaran (D3 MP), Manajemen Bisnis Internasional (S.Tr-MBI) dan Administrasi Bisnis Terapan (S.Tr ABT).\n\nUntuk meningkatkan standarisasi mutu program studi, Jurusan Administrasi Bisnis mengimplementasikan Gugus Kendali Mutu (GKM) yang berfokus pada penjaminan kualitas pembelajaran dan layanan akademik. Kegiatan ini melibatkan seluruh civitas akademika jurusan untuk memastikan proses pendidikan berjalan sesuai dengan standar yang telah ditetapkan.\n\nHasil dari implementasi GKM ini diharapkan dapat meningkatkan kualitas lulusan dan mempersiapkan program studi untuk akreditasi nasional maupun internasional di masa mendatang."
    },
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "10:33",
      "title": "PENDAMPINGAN DELEGASI BAC INTERNASIONAL DENGAN PENGIRIMAN DELEGASI 9 MATA LOMBA 2024",
      "content": "Dalam rangka mengembangkan prestasi akademik mahasiswa, Jurusan Administrasi Bisnis Politeknik Negeri Semarang, menyelenggarakan lomba bidang Administrasi Bisnis melalui kegiatan BAC (Business Administration Competition).\n\nKegiatan ini diikuti oleh 9 delegasi dari berbagai perguruan tinggi di Indonesia dan beberapa negara tetangga. Kategori lomba meliputi Business Plan, Marketing Strategy, Digital Business, Business Analysis, dan Business Communication.\n\nPendampingan delegasi dilakukan secara intensif oleh dosen-dosen Jurusan Administrasi Bisnis untuk memastikan performa optimal dalam kompetisi yang berlangsung selama 3 hari."
    },
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "05:31",
      "title": "DOSEN AB BULAN NOVEMBER 2024 MEMASUKI MASA PURNA TUGAS",
      "content": "DOSEN AB BULAN NOVEMBER 2024 MEMASUKI MASA PURNA TUGAS MASA PENGABDIAN 35 TAHUN YAITU Dra. ERIKA DEVIE, M.Ed.M.\n\nBeliau telah mengabdi di Politeknik Negeri Semarang selama 35 tahun dan memberikan kontribusi yang sangat berharga dalam pengembangan Jurusan Administrasi Bisnis.\n\nAcara pelepasan akan diselenggarakan pada tanggal 30 November 2024 di Aula Utama Polines dengan dihadiri seluruh civitas akademika dan keluarga besar Polines."
    },
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "05:27",
      "title": "PENYEMPURNAAN DOKUMEN AKREDITASI INTERNATIONAL 2024",
      "content": "MATERI WORKSHOP:\n\n1. Visi misi dan pengembangan keilmuan prodi\n\n2. Sumber daya manusia dosen\n\n3. Sarana dan prasarana\n\nWorkshop penyempurnaan dokumen akreditasi internasional ini diselenggarakan sebagai bagian dari persiapan Jurusan Administrasi Bisnis untuk menghadapi visitasi akreditasi internasional dari lembaga akreditasi ABEST21 yang akan dilaksanakan pada semester depan."
    },
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "05:24",
      "title": "Pemilihan Wirausaha Muda Pemula (WMP) Berprestasi Tingkat Nasional Tahun 2024 di raih oleh salah satu Dosen Jurusan Administrasi Bisnis",
      "content": "Dalam rangka menumbuhkan semangat dan motivasi wirausaha di kalangan pemuda. Kementerian Pemuda dan Olahraga (Kemenpora) melalui Deputi Bidang Pengembangan Pemuda mengajak wiramuda di lingkungan Provinsi, Kabupaten, Kota, dan Perguruan Tinggi yang berpotensi untuk dapat mengikuti Apresiasi Wirausaha Muda Pemula (WMP) Berprestasi Tahun 2024. Salah satunya diraih oleh Dosen Jurusan Ardinistrasi Bisnis POLINES yaitu MISBAKHUL ARREZQI , S.E., M.M. meraih JUARA 2."
    }
  ];

  @override
  Future<List<News>> getNews() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      developer.log("Starting to load news data");
      List<News> result = [];
      
      for (int i = 0; i < _sampleNewsData.length; i++) {
        try {
          developer.log("Processing news item $i");
          final newsItem = NewsModel.fromJson(_sampleNewsData[i]);
          result.add(newsItem);
          developer.log("Successfully processed news item $i with title: ${newsItem.title}");
        } catch (e) {
          developer.log("Error processing news item $i: $e", error: e);
        }
      }
      
      developer.log("News loading completed, found ${result.length} items");
      return result;
    } catch (e) {
      developer.log("Failed to load news: $e", error: e);
      throw Exception('Failed to load news: $e');
    }
  }

  @override
  Future<News> getNewsDetail(String id) async {
    // This would typically fetch a specific news item by ID
    // For this example, we'll just return the first news item
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final news = _sampleNewsData.first;
      return NewsModel.fromJson(news);
    } catch (e) {
      developer.log("Failed to load news detail: $e", error: e);
      throw Exception('Failed to load news detail: $e');
    }
  }
}