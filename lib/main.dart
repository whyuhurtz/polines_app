import 'package:flutter/material.dart';
import 'package:polines_app/features/fasilitas/presentation/screens/fasilitas_screen.dart';
import 'package:polines_app/features/home/presentation/screens/home_screen.dart';
import 'package:polines_app/features/program-studi/presentation/screens/programstudi_screen.dart';
import 'package:polines_app/features/tentang-jurusan/presentation/screens/tentangjurusan_screen.dart';
import 'package:polines_app/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Polines App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/jurusan': (context) => const TentangJurusanScreen(),
        '/prodi': (context) => const ProgramStudiScreen(),
        '/fasilitas': (context) => const FasilitasScreen(),
      },
    );
  }
}