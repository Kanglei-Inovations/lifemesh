import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lifemesh/core/app_colors.dart';
import 'package:lifemesh/widgets/radar_scanner.dart';
import 'package:lifemesh/features/chat/presentation/controllers/chat_controller.dart';
import 'package:lifemesh/features/chat/presentation/controllers/nearby_tab_controller.dart';
import 'package:lifemesh/models/nearby_user_model.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Column(
      children: [
        _buildAppBar(),
        _buildTabs(controller),
        Expanded(
          child: Obx(() {
            switch (controller.selectedTab.value) {
              case 1:
                return _buildGroupsView(controller);
              case 2:
                return _buildNearbyView(controller);
              default:
                return _buildAllChatsView(controller);
            }
          }),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSquareIcon(Icons.notes_rounded),
          Column(
            children: [
              const Text(
                'Mesh Chat',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '12 People Connected',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              _buildSquareIcon(Icons.search),
              const SizedBox(width: 12),
              _buildSquareIcon(Icons.add),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSquareIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildTabs(ChatController controller) {
    return Obx(() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildTabItem('All Chats', 0, controller, Icons.chat_bubble_outline),
          _buildTabItem('Groups', 1, controller, Icons.group_outlined),
          _buildTabItem('Nearby', 2, controller, Icons.explore_outlined),
        ],
      ),
    ));
  }

  Widget _buildTabItem(String label, int index, ChatController controller, IconData icon) {
    final isSelected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedTab.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: isSelected
                ? const LinearGradient(
                    colors: [
                      Color(0xFF6A4DFF),
                      Color(0xFF4D3DFF),
                    ],
                  )
                : null,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF6A4DFF).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- ALL CHATS VIEW ---
  Widget _buildAllChatsView(ChatController controller) {
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildMeshStatusCard(),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.chats.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withValues(alpha: 0.05),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final chat = controller.chats[index];
              return _buildChatTile(chat, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMeshStatusCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1F3D).withValues(alpha: 0.5),
            const Color(0xFF0D1127).withValues(alpha: 0.5),
          ],
        ),
        border: Border.all(
          color: AppColors.cyanBlue.withValues(alpha: 0.2),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 150,
            child: CustomPaint(painter: _MeshStatusPainter()),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                _buildHexagonIcon(),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Mesh Network Active',
                      style: TextStyle(
                        color: AppColors.cyanBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.lock_outline, color: Colors.greenAccent, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          'Strong Signal • Encrypted',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '12 People Online',
                      style: TextStyle(
                        color: AppColors.cyanBlue.withValues(alpha: 0.8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHexagonIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.cyanBlue.withValues(alpha: 0.3),
            Colors.transparent,
          ],
        ),
      ),
      child: const Center(
        child: Icon(Icons.hub_outlined, color: AppColors.cyanBlue, size: 30),
      ),
    );
  }

  Widget _buildChatTile(ChatSummary chat, int index) {
    return GestureDetector(
      onTap: () => Get.toNamed('/chat-detail', arguments: chat),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            _buildAvatar(chat.isOnline, chat.isWaiting, chat.avatar),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        chat.time,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      if (chat.isWaiting)
                        const Icon(Icons.access_time, color: Colors.orangeAccent, size: 12)
                      else
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.greenAccent.withValues(alpha: 0.7),
                          size: 12,
                        ),
                      const SizedBox(width: 4),
                      Text(
                        chat.distance,
                        style: TextStyle(
                          color: (chat.isWaiting ? Colors.orangeAccent : Colors.greenAccent).withValues(alpha: 0.7),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        chat.isDirect ? 'Direct' : 'Group',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.lock_outline,
                        color: Colors.white.withValues(alpha: 0.4),
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (chat.isMuted)
                  Icon(Icons.notifications_off_outlined, color: Colors.white38, size: 16),
                if (chat.unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4D3DFF),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${chat.unreadCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildAvatar(bool isOnline, bool isWaiting, [String? avatarUrl]) {
    return Stack(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              avatarUrl ?? 'https://pravatar.cc/100?u=avatar',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 2,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.deepNavy, width: 2),
              ),
            ),
          ),
        if (isWaiting)
          Positioned(
            right: 0,
            bottom: 2,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.deepNavy, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  // --- GROUPS VIEW ---
  Widget _buildGroupsView(ChatController controller) {
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildGroupsStatsCard(),
        const SizedBox(height: 24),
        _buildCommonFilterChips(['All', 'My Groups', 'Active', 'New Updates', 'Encrypted']),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.groups.length + 1, // +1 for the footer
            itemBuilder: (context, index) {
              if (index == controller.groups.length) {
                return _buildCreateGroupFooter();
              }
              final group = controller.groups[index];
              return _buildGroupTile(group, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGroupsStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1F3D).withValues(alpha: 0.5),
            const Color(0xFF0D1127).withValues(alpha: 0.5),
          ],
        ),
        border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MESH GROUP NETWORK',
                  style: TextStyle(
                    color: AppColors.neonPurple.withValues(alpha: 0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Active Groups',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '8',
                  style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('24 Members Online', style: TextStyle(color: Colors.greenAccent, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMiniStat(Icons.group_outlined, '8', 'Groups'),
                    _buildMiniStat(Icons.analytics_outlined, '85%', 'Avg. Stability'),
                    _buildMiniStat(Icons.security_outlined, 'Encrypted', 'End-to-End'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          _buildGroupMeshGraphic(),
        ],
      ),
    );
  }

  Widget _buildMiniStat(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.cyanBlue, size: 16),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white38, fontSize: 8)),
      ],
    );
  }

  Widget _buildGroupMeshGraphic() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neonPurple.withValues(alpha: 0.1),
              border: Border.all(color: AppColors.neonPurple.withValues(alpha: 0.5)),
            ),
            child: const Icon(Icons.group_work, color: AppColors.neonPurple, size: 30),
          ),
          CustomPaint(painter: _GroupMeshPainter(), size: const Size(100, 100)),
        ],
      ),
    );
  }

  Widget _buildGroupTile(GroupSummary group, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          _buildAvatar(true, false), // Reuse avatar widget
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      group.name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(group.time, style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  group.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '${group.memberCount} members',
                      style: const TextStyle(color: Colors.greenAccent, fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    Text('•', style: TextStyle(color: Colors.white38)),
                    const SizedBox(width: 8),
                    Text(
                      group.status,
                      style: const TextStyle(color: Colors.greenAccent, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(group.isMuted ? Icons.notifications_off_outlined : Icons.notifications_none, color: Colors.white38, size: 18),
              const SizedBox(height: 4),
              if (group.unreadCount > 0)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: Color(0xFF4D3DFF), shape: BoxShape.circle),
                  child: Text('${group.unreadCount}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(width: 8),
          Icon(Icons.more_vert, color: Colors.white38, size: 20),
        ],
      ),
    );
  }

  Widget _buildCreateGroupFooter() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.neonPurple.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.group_add_outlined, color: AppColors.neonPurple),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create a New Group', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                Text('Bring people together on the mesh network', style: TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4D3DFF),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
            ),
            child: const Row(
              children: [
                Text('Create Group', style: TextStyle(fontSize: 12)),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- NEARBY VIEW (REAL-TIME IMPLEMENTATION) ---
  Widget _buildNearbyView(ChatController chatController) {
    final nearbyController = Get.put(NearbyTabController());
    
    return Column(
      children: [
        const SizedBox(height: 16),
        _buildNearbyRadarCard(nearbyController),
        const SizedBox(height: 24),
        _buildNearbyFilterChips(['All', 'Strong Signal', 'Recently Seen', 'Connected', 'Friends'], nearbyController),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'NEARBY USERS',
                style: TextStyle(color: AppColors.cyanBlue, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
              Row(
                children: [
                  Text('Sorted by: ', style: TextStyle(color: Colors.white38, fontSize: 11)),
                  const Text('Signal', style: TextStyle(color: AppColors.cyanBlue, fontSize: 11, fontWeight: FontWeight.bold)),
                  const Icon(Icons.keyboard_arrow_down, color: AppColors.cyanBlue, size: 14),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Obx(() => nearbyController.filteredUsers.isEmpty 
            ? _buildEmptyNearbyState()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: nearbyController.filteredUsers.length + 1, // +1 for footer
                itemBuilder: (context, index) {
                  if (index == nearbyController.filteredUsers.length) {
                    return _buildStartDiscoveryFooter(nearbyController);
                  }
                  final user = nearbyController.filteredUsers[index];
                  return _buildRealNearbyTile(user, index);
                },
              ),
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyRadarCard(NearbyTabController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1F3D).withValues(alpha: 0.5),
            const Color(0xFF0D1127).withValues(alpha: 0.5),
          ],
        ),
        border: Border.all(color: AppColors.cyanBlue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const RadarScanner(),
                _NearbyRadarAvatars(controller: controller),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MESH DISCOVERY',
                  style: TextStyle(
                    color: AppColors.cyanBlue.withValues(alpha: 0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Obx(() => Text(
                      controller.discoveryStatus.value == 'Active' ? 'Discovering Nearby' : 'Discovery Paused', 
                      style: const TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)
                    )),
                  ],
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                  controller.discoveryStatus.value == 'Active' 
                    ? 'Scanning for LifeMesh users...' 
                    : 'Mesh state: ${controller.discoveryStatus.value}',
                  style: const TextStyle(color: Colors.white38, fontSize: 11)
                )),
                const SizedBox(height: 16),
                Obx(() => _buildNearbyStatRow(Icons.group_outlined, 'Nearby Devices', '${controller.nearbyDevicesCount.value}')),
                Obx(() => _buildNearbyStatRow(Icons.signal_cellular_alt, 'Signal Avg.', '${controller.signalAvg.value}%')),
                Obx(() => _buildNearbyStatRow(Icons.verified_user_outlined, 'Mesh Stability', '${controller.meshStability.value}%')),
                Obx(() => _buildNearbyStatRow(
                  Icons.track_changes, 
                  'Discovery Status', 
                  controller.discoveryStatus.value, 
                  valueColor: controller.discoveryStatus.value == 'Active' ? Colors.greenAccent : Colors.redAccent
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyStatRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.white38, size: 14),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: TextStyle(color: Colors.white38, fontSize: 11))),
          Text(value, style: TextStyle(color: valueColor ?? Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRealNearbyTile(NearbyUserModel user, int index) {
    final status = user.connectionStatus ?? 'idle';
    final signal = ((user.signalStrength ?? 0) * 100).round();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          _buildAvatar(user.isOnline, false, user.avatar),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(user.name ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 8),
                    _buildStatusBadge(user.isOnline ? 'Connected' : status.capitalizeFirst!),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Mesh ID: ${user.meshId?.substring(0, 8) ?? 'N/A'}', style: TextStyle(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(user.distance ?? 'Scanning...', style: const TextStyle(color: Colors.greenAccent, fontSize: 11)),
                    const SizedBox(width: 8),
                    Text('•', style: TextStyle(color: Colors.white38)),
                    const SizedBox(width: 8),
                    Text(user.deviceName ?? 'Nearby Device', style: TextStyle(color: Colors.white38, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.signal_cellular_alt, color: _getSignalColor(signal), size: 16),
                  const SizedBox(width: 4),
                  Text('$signal%', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(_getSignalLabel(signal), style: TextStyle(color: _getSignalColor(signal), fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 16),
          _buildActionButton(Icons.chat_bubble_outline),
          const SizedBox(width: 8),
          _buildActionButton(Icons.person_outline),
        ],
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildEmptyNearbyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.radar, size: 64, color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 16),
          const Text(
            'No nearby LifeMesh users detected.',
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getBadgeColor(text).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _getBadgeColor(text).withValues(alpha: 0.3)),
      ),
      child: Text(text, style: TextStyle(color: _getBadgeColor(text), fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }

  Color _getBadgeColor(String text) {
    switch (text) {
      case 'Connected': return const Color(0xFF6A4DFF);
      case 'Direct': return AppColors.cyanBlue;
      case 'Discovering': return Colors.orangeAccent;
      case 'Connecting': return Colors.yellowAccent;
      case 'New': return Colors.pinkAccent;
      default: return Colors.white38;
    }
  }

  Color _getSignalColor(int strength) {
    if (strength >= 70) return Colors.greenAccent;
    if (strength >= 40) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  String _getSignalLabel(int strength) {
    if (strength >= 70) return 'Strong';
    if (strength >= 40) return 'Medium';
    return 'Weak';
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }

  Widget _buildStartDiscoveryFooter(NearbyTabController controller) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          const Icon(Icons.radar, color: AppColors.cyanBlue, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('No more users?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                Text('Make sure Bluetooth & Wi-Fi are ON', style: TextStyle(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => controller.restartDiscovery(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4D3DFF),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Restart Discovery', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- COMMON COMPONENTS ---
  Widget _buildCommonFilterChips(List<String> labels) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ...labels.map((label) {
            final isFirst = labels.indexOf(label) == 0;
            return Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isFirst ? const Color(0xFF6A4DFF).withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isFirst ? const Color(0xFF6A4DFF) : Colors.white.withValues(alpha: 0.1)),
              ),
              child: Text(
                label,
                style: TextStyle(color: isFirst ? Colors.white : Colors.white38, fontSize: 12, fontWeight: isFirst ? FontWeight.bold : FontWeight.normal),
              ),
            );
          }),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.tune, color: Colors.white38, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyFilterChips(List<String> labels, NearbyTabController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ...labels.map((label) {
            return Obx(() {
              final isSelected = controller.selectedFilter.value == label;
              return GestureDetector(
                onTap: () => controller.setFilter(label),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF6A4DFF).withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSelected ? const Color(0xFF6A4DFF) : Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(color: isSelected ? Colors.white : Colors.white38, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                  ),
                ),
              );
            });
          }),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.tune, color: Colors.white38, size: 16),
          ),
        ],
      ),
    );
  }
}

class _MeshStatusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.cyanBlue.withValues(alpha: 0.1)..style = PaintingStyle.stroke..strokeWidth = 1;
    final dotPaint = Paint()..color = AppColors.cyanBlue.withValues(alpha: 0.3)..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.5), 20, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.5), 10, paint);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.3), 3, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 3, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.7), 3, dotPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.8), 3, dotPaint);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GroupMeshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.neonPurple.withValues(alpha: 0.3)..style = PaintingStyle.stroke..strokeWidth = 1;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    for (int i = 0; i < 5; i++) {
      final angle = (i * 72) * (3.14159 / 180);
      final pt = Offset(center.dx + cos(angle) * radius, center.dy + sin(angle) * radius);
      canvas.drawLine(center, pt, paint);
      for (int j = i + 1; j < 5; j++) {
        final angle2 = (j * 72) * (3.14159 / 180);
        final pt2 = Offset(center.dx + cos(angle2) * radius, center.dy + sin(angle2) * radius);
        canvas.drawLine(pt, pt2, paint);
      }
      canvas.drawCircle(pt, 12, Paint()..color = AppColors.deepNavy);
      canvas.drawCircle(pt, 12, paint);
    }
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NearbyRadarAvatars extends StatelessWidget {
  final NearbyTabController controller;
  const _NearbyRadarAvatars({required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final center = Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
        return Obx(() {
          final users = controller.nearbyUsers;
          return Stack(
            children: List.generate(users.length, (index) {
              final user = users[index];
              final signal = user.signalStrength ?? 0.0;
              
              // Angle based on index to spread them out
              final angle = (index * (360 / max(1, users.length))) * (pi / 180);
              
              // Distance based on signal strength (Higher signal = closer to center)
              // Radius is min(width, height) / 2
              final maxRadius = constraints.maxWidth / 2;
              final dist = maxRadius * (1.1 - signal.clamp(0.2, 0.9)); 
              
              return Positioned(
                left: center.dx + cos(angle) * dist - 12,
                top: center.dy + sin(angle) * dist - 12,
                child: Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.cyanBlue, width: 1),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      user.avatar ?? 'https://pravatar.cc/100?u=${user.meshId}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.white, size: 12),
                    ),
                  ),
                ),
              ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack).fadeIn();
            }),
          );
        });
      }
    );
  }
}
