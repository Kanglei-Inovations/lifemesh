import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GamesController extends GetxController {
  var availableGames = <GameItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockGames();
  }

  void loadMockGames() {
    availableGames.value = [
      GameItem(
        title: "Mesh Racer",
        players: "2-4",
        latency: "12ms",
        icon: Icons.speed,
        color: Colors.cyanAccent,
        description: "High-speed racing over local mesh nodes.",
      ),
      GameItem(
        title: "Node Capture",
        players: "Team vs Team",
        latency: "45ms",
        icon: Icons.hub,
        color: Colors.purpleAccent,
        description: "Strategic territory control game.",
      ),
      GameItem(
        title: "Cyber Chess",
        players: "2",
        latency: "5ms",
        icon: Icons.grid_4x4,
        color: Colors.orangeAccent,
        description: "Classic chess with futuristic abilities.",
      ),
    ];
  }
}

class GameItem {
  final String title;
  final String players;
  final String latency;
  final IconData icon;
  final Color color;
  final String description;

  GameItem({
    required this.title,
    required this.players,
    required this.latency,
    required this.icon,
    required this.color,
    required this.description,
  });
}
