import 'package:get/get.dart';

class DisasterController extends GetxController {
  var isSOSActive = false.obs;
  var nearbyAlerts = <EmergencyAlert>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockAlerts();
  }

  void loadMockAlerts() {
    nearbyAlerts.value = [
      EmergencyAlert(
        title: "Power Outage - Sector 7",
        description: "Grid failure detected. Local mesh relaying status.",
        severity: "Medium",
        time: "15m ago",
      ),
      EmergencyAlert(
        title: "Flood Warning - River Side",
        description: "Water levels rising. Evacuate to higher ground.",
        severity: "High",
        time: "45m ago",
      ),
      EmergencyAlert(
        title: "Safe Zone Established",
        description: "Community Center has backup power and medical supplies.",
        severity: "Low",
        time: "1h ago",
      ),
    ];
  }

  void toggleSOS() {
    isSOSActive.value = !isSOSActive.value;
  }
}

class EmergencyAlert {
  final String title;
  final String description;
  final String severity;
  final String time;

  EmergencyAlert({
    required this.title,
    required this.description,
    required this.severity,
    required this.time,
  });
}
