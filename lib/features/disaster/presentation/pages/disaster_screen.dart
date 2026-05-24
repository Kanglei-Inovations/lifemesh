import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../controllers/disaster_controller.dart';

class DisasterScreen extends StatelessWidget {
  const DisasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisasterController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'DISASTER MODE',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 16, color: Colors.redAccent),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildSOSButton(controller),
            const SizedBox(height: 40),
            _buildSectionHeader('EMERGENCY BROADCASTS'),
            const SizedBox(height: 16),
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.nearbyAlerts.length,
                  itemBuilder: (context, index) {
                    final alert = controller.nearbyAlerts[index];
                    return _buildAlertCard(alert, index);
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSButton(DisasterController controller) {
    return Obx(() => GestureDetector(
          onTap: () => controller.toggleSOS(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Glowing Rings
              if (controller.isSOSActive.value)
                ...List.generate(3, (index) => 
                  Container(
                    width: 200 + (index * 40),
                    height: 200 + (index * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3 - (index * 0.1)), width: 2),
                    ),
                  ).animate(onPlay: (c) => c.repeat()).scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.2, 1.2),
                    duration: (1000 + (index * 200)).ms,
                    curve: Curves.easeOut,
                  ).fadeOut()
                ),
              
              // Main SOS Button
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.isSOSActive.value ? Colors.redAccent : Colors.redAccent.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.redAccent, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withValues(alpha: 0.5),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      controller.isSOSActive.value ? Icons.warning_rounded : Icons.punch_clock_outlined,
                      size: 60,
                      color: controller.isSOSActive.value ? Colors.white : Colors.redAccent,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.isSOSActive.value ? 'SOS ACTIVE' : 'BROADCAST SOS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: controller.isSOSActive.value ? Colors.white : Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        const Icon(Icons.emergency_share, color: Colors.redAccent, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ],
    );
  }

  Widget _buildAlertCard(EmergencyAlert alert, int index) {
    Color severityColor = alert.severity == 'High' ? Colors.redAccent : (alert.severity == 'Medium' ? Colors.orangeAccent : Colors.blueAccent);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 110,
        borderRadius: 20,
        blur: 15,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [Colors.red.withValues(alpha: 0.1), Colors.black.withValues(alpha: 0.2)],
        ),
        borderGradient: LinearGradient(
          colors: [severityColor.withValues(alpha: 0.5), Colors.transparent],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: severityColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(alert.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(alert.time, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.4))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1, end: 0);
  }
}
