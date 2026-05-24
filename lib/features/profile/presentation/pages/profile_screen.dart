import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildMeshStats(),
            const SizedBox(height: 30),
            _buildActionList(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
              ),
            ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 3.seconds),
            const CircleAvatar(
              radius: 56,
              backgroundColor: AppColors.deepNavy,
              child: Icon(Icons.person, size: 60, color: AppColors.cyanBlue),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Nexus-User',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'Mesh ID: 8f2k-99p1-qx72',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 12,
          ),
        ),
      ],
    ).animate().fadeIn().scale();
  }

  Widget _buildMeshStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('Peers Met', '142'),
        _buildStatItem('Data Shared', '12.4 GB'),
        _buildStatItem('Reputation', '98%'),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.cyanBlue,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildActionList() {
    return Column(
      children: [
        _buildActionTile(
          Icons.qr_code,
          'My Mesh QR',
          'Share your identity offline',
        ),
        _buildActionTile(
          Icons.security,
          'Privacy & Encryption',
          'Manage your local keys',
        ),
        _buildActionTile(
          Icons.storage,
          'Offline Storage',
          '2.4 GB used / 10 GB',
        ),
        _buildActionTile(
          Icons.settings,
          'Mesh Settings',
          'Relay permissions & protocols',
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle) {
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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}
