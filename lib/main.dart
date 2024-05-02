import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_mobile/auth/auth_provider.dart';
import 'package:smart_home_mobile/onboarding/splash_screen.dart';
import 'package:smart_home_mobile/remote/remote_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => RemoteProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
