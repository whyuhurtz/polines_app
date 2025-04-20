import 'dart:convert';
import 'dart:developer' as developer;
// import 'package:flutter/foundation.dart';
import 'package:polines_app/features/home/data/models/news_model.dart';
import 'package:polines_app/features/home/domain/entities/news_entity.dart';
import 'package:polines_app/features/home/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  // This would typically come from a data source like API or local DB
  // For this example, we're hardcoding some sample data
  final List<String> _sampleNewsJson = [
    '''
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "10:42",
      "title": "IMPLEMENTASI GKM UNTUK MENDUKUNG STANDARISASI MUTU PROGRAM STUDI DAN JURUSAN ADMINISTRASI 2024",
      "content": "Jurusan Administrasi Bisnis (AB) Politeknik Negeri Semarang (Polines) hingga tahun 2021 mempunyai 4 (empat) Program Studi, yaitu Program Studi Administrasi Bisnis (D3-AB), Manajemen Pemasaran (D3 MP), Manajemen Bisnis Internasional (S.Tr-MBI) dan Administrasi Bisnis Terapan (S.Tr ABT)."
    }
    ''',
    '''
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "10:33",
      "title": "PENDAMPINGAN DELEGASI BAC INTERNASIONAL DENGAN PENGIRIMAN DELEGASI 9 MATA LOMBA 2024",
      "content": "Dalam rangka mengembangkan prestasi akademik mahasiswa, Jurusan Administrasi Bisnis Politeknik Negeri Semarang, menyelenggarakan lomba bidang Administrasi Bisnis melalui kegiatan BAC (Business Administration Competition)."
    }
    ''',
    '''
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "05:31",
      "title": "DOSEN AB BULAN NOVEMBER 2024 MEMASUKI MASA PURNA TUGAS",
      "content": "DOSEN AB BULAN NOVEMBER 2024 MEMASUKI MASA PURNA TUGAS MASA PENGABDIAN 35 TAHUN YAITU Dra. ERIKA DEVIE , M.Ed.M."
    }
    ''',
    '''
    {
      "author": "arifhatmojo",
      "date_published": "Thu, 07/11/2024",
      "time_published": "05:27",
      "title": "PENYEMPURNAAN DOKUMEN AKREDITASI INTERNATIONAL 2024",
      "content": "MATERI WORKSHOP: 1. visi misi dan pengembangan keilmuan prodi 2. sumber daya manusia dosen 3. sarana dan prasarana"
    }
    '''
  ];

  @override
  Future<List<News>> getNews() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      developer.log("Starting to load news data");
      List<News> result = [];
      
      for (int i = 0; i < _sampleNewsJson.length; i++) {
        try {
          final jsonStr = _sampleNewsJson[i];
          developer.log("Processing news item $i: ${jsonStr.substring(0, 50)}...");
          
          final Map<String, dynamic> jsonMap = json.decode(jsonStr);
          final newsItem = NewsModel.fromJson(jsonMap);
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
      final news = _sampleNewsJson.first;
      return NewsModel.fromJson(json.decode(news));
    } catch (e) {
      developer.log("Failed to load news detail: $e", error: e);
      throw Exception('Failed to load news detail: $e');
    }
  }
}