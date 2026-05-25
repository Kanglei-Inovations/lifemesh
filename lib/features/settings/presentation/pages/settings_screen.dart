import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MeshBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      _buildSectionHeader('NETWORK SETTINGS'),
                      _buildSettingTile(
                        Icons.hub_outlined,
                        'Relay Mode',
                        'Allow device to relay mesh packets',
                        true,
                      ),
                      _buildSettingTile(
                        Icons.bluetooth,
                        'Bluetooth LE',
                        'High-efficiency discovery',
                        true,
                      ),
                      _buildSettingTile(
                        Icons.wifi_tethering,
                        'WiFi Direct',
                        'High-speed file transfers',
                        false,
                      ),

                      const SizedBox(height: 30),
                      _buildSectionHeader('AI & MEMORY'),
                      _buildSettingTile(
                        Icons.auto_awesome,
                        'Local AI Processing',
                        'Enable on-device LLM',
                        true,
                      ),
                      _buildSettingTile(
                        Icons.history,
                        'Timeline Depth',
                        'Store last 30 days',
                        null,
                      ),

                      const SizedBox(height: 30),
                      _buildSectionHeader('SECURITY'),
                      _buildSettingTile(
                        Icons.lock_outline,
                        'End-to-End Encryption',
                        'Always active',
                        true,
                      ),
                      _buildSettingTile(
                        Icons.key,
                        'Local Keys',
                        'Manage mesh identity keys',
                        null,
                      ),

                      const SizedBox(height: 30),
                      _buildSectionHeader('SYSTEM'),
                      _buildSettingTile(
                        Icons.battery_saver,
                        'Battery Optimization',
                        'Balance mesh & power',
                        true,
                      ),
                      _buildSettingTile(
                        Icons.storage,
                        'Clear Mesh Cache',
                        'Used: 1.2 GB',
                        null,
                      ),

                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          'LifeMesh v1.0.0-beta\nNode ID: 8f2k-99p1-qx72',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white24, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton.icon(
                          onPressed: () => Get.toNamed('/debug-panel'),
                          icon: const Icon(Icons.bug_report, color: Colors.white38, size: 16),
                          label: const Text('Developer Debug Panel', style: TextStyle(color: Colors.white38, fontSize: 12)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const Text(
            'SETTINGS',
            style: TextStyle(
              color: AppColors.cyanBlue,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          const Icon(Icons.settings_outlined, color: AppColors.cyanBlue),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    IconData icon,
    String title,
    String subtitle,
    bool? value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.cyanBlue),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          trailing: value != null
              ? Switch(
                  value: value,
                  onChanged: (v) {},
                  activeThumbColor: AppColors.cyanBlue,
                )
              : const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white24,
                ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }
}
