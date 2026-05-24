import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../../../core/app_colors.dart';
import '../controllers/marketplace_controller.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MarketplaceController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'MESH MARKET',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.cyanBlue,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryBar(controller),
          Expanded(
            child: Obx(
              () => GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return _buildMarketItem(item, index);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.neonPurple,
        icon: const Icon(Icons.add_business),
        label: const Text('SELL ITEM'),
      ),
    );
  }

  Widget _buildCategoryBar(MarketplaceController controller) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final isSelected = controller.selectedCategory.value == category;
            return GestureDetector(
              onTap: () => controller.selectedCategory.value = category,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.cyanBlue.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.cyanBlue : Colors.white10,
                  ),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? AppColors.cyanBlue : Colors.white70,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMarketItem(MarketItem item, int index) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: double.infinity,
      borderRadius: 20,
      blur: 15,
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
          AppColors.cyanBlue.withValues(alpha: 0.2),
          AppColors.neonPurple.withValues(alpha: 0.2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.neonPurple.withValues(alpha: 0.1),
                    AppColors.cyanBlue.withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 40,
                color: Colors.white24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.price,
                      style: const TextStyle(
                        color: AppColors.cyanBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.distance,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 12,
                      color: Colors.white38,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.seller,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 100).ms).scale();
  }
}
