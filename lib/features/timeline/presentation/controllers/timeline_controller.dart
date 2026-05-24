import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TimelineController extends GetxController {
  var events = <TimelineEvent>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockEvents();
  }

  void loadMockEvents() {
    events.value = [
      TimelineEvent(
        time: "09:42 AM",
        title: "Mesh Connection Established",
        description:
            "Connected to 14 nodes in Sector 4. Signal strength: Excellent.",
        icon: Icons.hub_outlined,
        color: Colors.cyanAccent,
      ),
      TimelineEvent(
        time: "11:15 AM",
        title: "Met Nexus-Alpha",
        description: "Interaction detected for 45 minutes. Shared 3 files.",
        icon: Icons.person_search_outlined,
        color: Colors.purpleAccent,
      ),
      TimelineEvent(
        time: "01:30 PM",
        title: "File Relay Active",
        description: "Relayed 450MB of data for nearby emergency alerts.",
        icon: Icons.share_outlined,
        color: Colors.orangeAccent,
      ),
      TimelineEvent(
        time: "04:20 PM",
        title: "AI Memory Snapshot",
        description:
            "Reconstructed interaction patterns from local node history.",
        icon: Icons.auto_awesome,
        color: Colors.amberAccent,
      ),
    ];
  }
}

class TimelineEvent {
  final String time;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  TimelineEvent({
    required this.time,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
