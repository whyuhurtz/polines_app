import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:polines_app/features/tentang-jurusan/data/repositories/tentangjurusan_repository_impl.dart';
import 'package:polines_app/features/tentang-jurusan/domain/entities/tentangjurusan_entity.dart';
import 'package:polines_app/features/tentang-jurusan/presentation/widgets/content_tab_button.dart';
import 'package:polines_app/features/tentang-jurusan/presentation/widgets/header_carousel_widget.dart';
import 'package:polines_app/features/tentang-jurusan/presentation/widgets/tentang_content_widget.dart';
import 'package:polines_app/presentation/widgets/bottom_navbar.dart';

enum ContentType { tentang, visi, misi }

class TentangJurusanScreen extends StatefulWidget {
  const TentangJurusanScreen({Key? key}) : super(key: key);

  @override
  State<TentangJurusanScreen> createState() => _TentangJurusanScreenState();
}

class _TentangJurusanScreenState extends State<TentangJurusanScreen> {
  final _repository = TentangJurusanRepositoryImpl();
  bool _isLoading = true;
  TentangJurusan? _tentangJurusan;
  ContentType _selectedContentType = ContentType.tentang;
  int _selectedIndex = 1; // For bottom navbar, set to Jurusan tab

  @override
  void initState() {
    super.initState();
    _loadTentangJurusanData();
  }

  // Handle navigation when bottom navbar tab is changed
  void _onTabChange(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/prodi');
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/fasilitas');
      }
    }
  }

  Future<void> _loadTentangJurusanData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final data = await _repository.getTentangJurusan();
      
      setState(() {
        _tentangJurusan = data;
        _isLoading = false;
      });
    } catch (e) {
      developer.log('Error loading tentang jurusan data: $e', error: e);
      
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal memuat data jurusan'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Jurusan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF04428B), // polinesBlue
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadTentangJurusanData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Header Carousel
                    const HeaderCarouselWidget(
                      imagePaths: [
                        'assets/images/banner_jurusan1.jpg',
                        'assets/images/banner_jurusan2.jpg',
                        'assets/images/banner_jurusan3.jpg',
                        'assets/images/banner_jurusan4.jpg',
                        'assets/images/banner_jurusan5.jpg'
                      ],
                      height: 200,
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tab Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ContentTabButton(
                                text: 'Tentang',
                                isSelected: _selectedContentType == ContentType.tentang,
                                onPressed: () {
                                  setState(() {
                                    _selectedContentType = ContentType.tentang;
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              ContentTabButton(
                                text: 'Visi',
                                isSelected: _selectedContentType == ContentType.visi,
                                onPressed: () {
                                  setState(() {
                                    _selectedContentType = ContentType.visi;
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              ContentTabButton(
                                text: 'Misi',
                                isSelected: _selectedContentType == ContentType.misi,
                                onPressed: () {
                                  setState(() {
                                    _selectedContentType = ContentType.misi;
                                  });
                                },
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Dynamic Content based on selected tab
                          if (_tentangJurusan != null) _buildSelectedContent(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (_selectedContentType) {
      case ContentType.tentang:
        return TentangContentWidget(content: _tentangJurusan!.tentang ?? '');
      case ContentType.visi:
        return VisiContentWidget(visi: _tentangJurusan!.visi ?? '');
      case ContentType.misi:
        if (_tentangJurusan!.misi != null) {
          return MisiContentWidget(misi: _tentangJurusan!.misi!);
        } else {
          return const Center(child: Text('Misi tidak tersedia'));
        }
    }
  }
}

