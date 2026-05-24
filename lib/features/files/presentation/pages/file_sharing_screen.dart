import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../../../../widgets/mesh_background.dart';
import '../controllers/file_sharing_controller.dart';

class FileSharingScreen extends StatelessWidget {
  const FileSharingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FileSharingController());
    controller.loadMockFiles();

    return Scaffold(
      body: Stack(
        children: [
          const MeshBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTransferSection(controller),
                        const SizedBox(height: 30),
                        Text(
                          'SELECTED FILES',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildFileList(controller),
                      ],
                    ),
                  ),
                ),
                _buildBottomAction(controller),
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
            'FILE SHARING',
            style: TextStyle(
              color: AppColors.cyanBlue,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          const Icon(Icons.share_outlined, color: AppColors.cyanBlue),
        ],
      ),
    );
  }

  Widget _buildTransferSection(FileSharingController controller) {
    return Obx(
      () => GlassmorphicContainer(
        width: double.infinity,
        height: 200,
        borderRadius: 24,
        blur: 20,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            AppColors.cyanBlue.withValues(alpha: 0.5),
            AppColors.neonPurple.withValues(alpha: 0.5),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: controller.transferProgress.value,
                    strokeWidth: 8,
                    backgroundColor: Colors.white10,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.cyanBlue,
                    ),
                  ),
                ),
                Icon(
                      controller.isTransferring.value
                          ? Icons.upload_file
                          : Icons.cloud_done_outlined,
                      size: 40,
                      color: AppColors.cyanBlue,
                    )
                    .animate(target: controller.isTransferring.value ? 1 : 0)
                    .shimmer(),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              controller.isTransferring.value
                  ? 'Transferring... ${(controller.transferProgress.value * 100).toInt()}%'
                  : 'Ready to Sync',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Nearby: 4 active peers',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileList(FileSharingController controller) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.selectedFiles.length,
        itemBuilder: (context, index) {
          final file = controller.selectedFiles[index];
          return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(file.icon, color: AppColors.cyanBlue),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            file.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${file.size} • ${file.type}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.close, size: 20, color: Colors.white24),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: (index * 100).ms)
              .slideX(begin: 0.1, end: 0);
        },
      ),
    );
  }

  Widget _buildBottomAction(FileSharingController controller) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Obx(
        () => ElevatedButton(
          onPressed: controller.isTransferring.value
              ? null
              : () => controller.startTransfer(),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: AppColors.neonPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            controller.isTransferring.value
                ? 'TRANSFER IN PROGRESS'
                : 'BROADCAST TO MESH',
            style: const TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
