import 'package:flutter/material.dart';
import 'package:polines_app/features/program-studi/data/repositories/kompetensilulusan_repository_impl.dart';
import 'package:polines_app/features/program-studi/domain/entities/kompetensilulusan_entity.dart';
import 'package:polines_app/features/program-studi/presentation/screens/kompetensi_detail_screen.dart';
import 'package:polines_app/features/program-studi/presentation/screens/list_kompetensi_screen.dart';

class KompetensiContentWidget extends StatefulWidget {
  const KompetensiContentWidget({Key? key}) : super(key: key);

  @override
  State<KompetensiContentWidget> createState() => _KompetensiContentWidgetState();
}

class _KompetensiContentWidgetState extends State<KompetensiContentWidget> {
  final KompetensiLulusanRepositoryImpl _repository = KompetensiLulusanRepositoryImpl();
  bool _isLoading = true;
  KompetensiLulusan? _kompetensiData;
  String? _errorMessage;

  // Colors based on Polines branding
  static const Color polinesBlue = Color(0xFF04428B);
  static const Color polinesYellow = Color(0xFFF6C31A);
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 32),
            const SizedBox(height: 12),
            Text(_errorMessage!),
            const SizedBox(height: 12),
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

    if (_kompetensiData == null || _kompetensiData!.profilLulusan == null || _kompetensiData!.profilLulusan!.isEmpty) {
      return const Center(
        child: Text('Tidak ada data kompetensi lulusan tersedia'),
      );
    }

    // Limit to show first 3 items only on the main screen
    final displayItems = _kompetensiData!.profilLulusan!.length > 3
        ? _kompetensiData!.profilLulusan!.sublist(0, 3)
        : _kompetensiData!.profilLulusan!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title and "see all" button in same row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Kompetensi Lulusan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: polinesBlue,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListKompetensiScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'see all',
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 12,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
        
        // Reduced gap between header and list (from 16+8 to just 12)
        const SizedBox(height: 12),
        
        // List kompetensi with redesigned cards
        ...List.generate(displayItems.length, (index) {
          final kompetensi = displayItems[index];
          return _buildKompetensiItem(
            (index + 1).toString(),
            kompetensi.title ?? "Untitled",
            kompetensi.content ?? "No description available",
            context,
          );
        }),
      ],
    );
  }

  Widget _buildKompetensiItem(String number, String title, String description, BuildContext context) {
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
              
              // Title and arrow
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