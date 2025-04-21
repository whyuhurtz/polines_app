import 'package:flutter/material.dart';
import 'package:polines_app/features/program-studi/data/repositories/kompetensilulusan_repository_impl.dart';
import 'package:polines_app/features/program-studi/domain/entities/kompetensilulusan_entity.dart';
import 'package:polines_app/features/program-studi/presentation/screens/kompetensi_detail_screen.dart';

class ListKompetensiScreen extends StatefulWidget {
  const ListKompetensiScreen({Key? key}) : super(key: key);

  @override
  State<ListKompetensiScreen> createState() => _ListKompetensiScreenState();
}

class _ListKompetensiScreenState extends State<ListKompetensiScreen> {
  final KompetensiLulusanRepositoryImpl _repository = KompetensiLulusanRepositoryImpl();
  bool _isLoading = true;
  KompetensiLulusan? _kompetensiData;
  String? _errorMessage;

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
  static const Color polinesLightBg = Color(0xFFF6F8FD);
  static const Color polinesWhite = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _loadKompetensiData();
  }

  Future<void> _loadKompetensiData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final data = await _repository.getKompetensiLulusan();

      if (!mounted) return;

      setState(() {
        _kompetensiData = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: polinesLightBg,
      appBar: AppBar(
        title: const Text(
          'Kompetensi Lulusan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: polinesBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : _errorMessage != null 
          ? _buildErrorWidget() 
          : _buildContent(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            _errorMessage ?? 'Terjadi kesalahan',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadKompetensiData,
            style: ElevatedButton.styleFrom(
              backgroundColor: polinesYellow,
              foregroundColor: polinesBlue,
            ),
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_kompetensiData == null || _kompetensiData!.profilLulusan == null || _kompetensiData!.profilLulusan!.isEmpty) {
      return const Center(
        child: Text('Tidak ada data kompetensi lulusan tersedia'),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: polinesYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kompetensi Lulusan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: polinesBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Berikut adalah kompetensi lulusan Politeknik Negeri Semarang yang siap bersaing di dunia kerja.',
                    style: TextStyle(
                      fontSize: 14,
                      color: polinesBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Display all kompetensi items
            ...List.generate(_kompetensiData!.profilLulusan!.length, (index) {
              final kompetensi = _kompetensiData!.profilLulusan![index];
              return _buildKompetensiItem(
                (index + 1).toString(),
                kompetensi.title ?? "Untitled",
                kompetensi.content ?? "No description available",
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildKompetensiItem(String number, String title, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KompetensiDetailScreen(
              number: number,
              title: title,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: polinesWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Number container
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: polinesYellow,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: polinesBlue,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Title and description in a column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: polinesBlue,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Arrow icon
              const Icon(
                Icons.arrow_forward_ios,
                color: polinesBlue,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}