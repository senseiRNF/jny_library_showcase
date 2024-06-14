import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jny_library_showcase/controllers/home_page_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft
  ]);

  runApp(const JNYLibraryShowcaseApp());
}

class JNYLibraryShowcaseApp extends StatelessWidget {
  const JNYLibraryShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JNY Library Showcase',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff632d6a)),
        fontFamily: 'Onest',
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
