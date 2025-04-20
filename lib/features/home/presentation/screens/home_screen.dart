import 'package:flutter/material.dart';
import 'package:polines_app/presentation/widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Handle navigation based on selected tab
    // This will be replaced with actual navigation logic when the other screens are created
    if (index != 0) {
      // Temporarily show a snackbar for tabs that don't have screens yet
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${index == 1 ? 'Jurusan' : index == 2 ? 'Prodi' : 'Fasilitas'} screen coming soon!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF04428B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Screen!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jurusan');
              },
              child: const Text('Go to Jurusan Screen'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}