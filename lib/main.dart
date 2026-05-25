import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app_theme.dart';
import 'features/auth/presentation/pages/splash_screen.dart';
import 'features/auth/presentation/pages/identity_screen.dart';
import 'features/auth/presentation/pages/personal_info_screen.dart';
import 'features/auth/presentation/pages/permissions_screen.dart';
import 'features/auth/presentation/pages/discovering_nearby_screen.dart';
import 'features/auth/presentation/pages/review_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/files/presentation/pages/file_sharing_screen.dart';
import 'features/disaster/presentation/pages/disaster_screen.dart';
import 'features/chat/presentation/pages/chat_detail_screen.dart';
import 'features/marketplace/presentation/pages/marketplace_screen.dart';
import 'features/games/presentation/pages/games_screen.dart';

import 'features/settings/presentation/pages/debug_panel_screen.dart';

import 'package:lifemesh/core/database_service.dart';
import 'package:lifemesh/core/services/crypto_service.dart';
import 'package:lifemesh/core/services/background_mesh_service.dart';
import 'package:lifemesh/core/services/nearby_service.dart';
import 'package:lifemesh/core/network/local_node_server.dart';
import 'package:lifemesh/core/network/lan_discovery_service.dart';
import 'package:lifemesh/core/network/message_bus.dart';
import 'package:lifemesh/core/services/mesh_network_service.dart';

import 'features/settings/presentation/pages/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DatabaseService().init());
  Get.put(CryptoService());
  Get.put(MessageBus());
  Get.put(BackgroundMeshService());
  
  // Register Hybrid Discovery Services
  await Get.putAsync(() => LocalNodeServer().init(), permanent: true);
  await Get.putAsync(() => LanDiscoveryService().init(), permanent: true);
  await Get.putAsync(() => NearbyService().init(), permanent: true);
  await Get.putAsync(() => MeshNetworkService().init(), permanent: true);

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
        GetPage(name: '/discovering', page: () => const DiscoveringNearbyScreen(),),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/settings', page: () => const SettingsScreen()),
        GetPage(name: '/file-sharing', page: () => const FileSharingScreen()),
        GetPage(name: '/disaster', page: () => const DisasterScreen()),
        GetPage(name: '/chat-detail', page: () => const ChatDetailScreen()),
        GetPage(name: '/marketplace', page: () => const MarketplaceScreen()),
        GetPage(name: '/games', page: () => const GamesScreen()),
        GetPage(name: '/debug-panel', page: () => const DebugPanelScreen()),
      ],
    );
  }
}
