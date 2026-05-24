import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app_theme.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'features/auth/presentation/pages/identity_screen.dart';
import 'features/auth/presentation/pages/personal_info_screen.dart';
import 'features/auth/presentation/pages/permissions_screen.dart';
import 'features/auth/presentation/pages/discovering_nearby_screen.dart';
import 'features/auth/presentation/pages/review_screen.dart';
import 'features/auth/presentation/pages/welcome_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/files/presentation/pages/file_sharing_screen.dart';
import 'features/disaster/presentation/pages/disaster_screen.dart';
import 'features/chat/presentation/pages/chat_detail_screen.dart';
import 'features/marketplace/presentation/pages/marketplace_screen.dart';
import 'features/games/presentation/pages/games_screen.dart';

import 'package:lifemesh/core/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DatabaseService().init());
  runApp(const LifeMeshApp());
}

class LifeMeshApp extends StatelessWidget {
  const LifeMeshApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LifeMesh',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/identity', page: () => const IdentityScreen()),
        GetPage(name: '/personal-info', page: () => const PersonalInfoScreen()),
        GetPage(name: '/review', page: () => const ReviewScreen()),
        GetPage(name: '/permissions', page: () => const PermissionsScreen()),
        GetPage(name: '/discovering', page: () => const DiscoveringNearbyScreen()),
        GetPage(name: '/welcome', page: () => const WelcomeScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/file-sharing', page: () => const FileSharingScreen()),
        GetPage(name: '/disaster', page: () => const DisasterScreen()),
        GetPage(name: '/chat-detail', page: () => const ChatDetailScreen()),
        GetPage(name: '/marketplace', page: () => const MarketplaceScreen()),
        GetPage(name: '/games', page: () => const GamesScreen()),
      ],
    );
  }
}