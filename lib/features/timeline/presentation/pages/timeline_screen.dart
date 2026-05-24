import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../controllers/timeline_controller.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimelineController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'AI TIMELINE',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_today_outlined, color: AppColors.cyanBlue),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAIHeader(),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.events.length,
                  itemBuilder: (context, index) {
                    final event = controller.events[index];
                    return _buildTimelineItem(event, index, index == controller.events.length - 1);
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildAIHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 100,
        borderRadius: 24,
        blur: 20,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [AppColors.cyanBlue.withValues(alpha: 0.1), AppColors.neonPurple.withValues(alpha: 0.1)],
        ),
        borderGradient: LinearGradient(
          colors: [AppColors.cyanBlue.withValues(alpha: 0.5), AppColors.neonPurple.withValues(alpha: 0.5)],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 30),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI SUMMARY: MARCH 14',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Today you interacted with 12 new peers and shared 1.2GB of mesh data.',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn().slideY(begin: -0.2, end: 0),
    );
  }

  Widget _buildTimelineItem(TimelineEvent event, int index, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: event.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: event.color.withValues(alpha: 0.5)),
                ),
                child: Icon(event.icon, size: 20, color: event.color),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.white10,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.time,
                    style: const TextStyle(color: AppColors.cyanBlue, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.6), height: 1.4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1, end: 0);
  }
}
