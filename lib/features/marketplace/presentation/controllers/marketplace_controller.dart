import 'package:get/get.dart';

class MarketplaceController extends GetxController {
  var items = <MarketItem>[].obs;
  var categories = ["All", "Tech", "Services", "Food", "Other"].obs;
  var selectedCategory = "All".obs;

  @override
  void onInit() {
    super.onInit();
    loadMockItems();
  }

  void loadMockItems() {
    items.value = [
      MarketItem(
        title: "Cyberpunk Jacket",
        price: "120 MSH",
        distance: "400m",
        image: "assets/images/item1.jpg",
        seller: "NeonRetailer",
        category: "Tech",
      ),
      MarketItem(
        title: "Mesh Relay Node V2",
        price: "45 MSH",
        distance: "1.2km",
        image: "assets/images/item2.jpg",
        seller: "HardwareHacker",
        category: "Tech",
      ),
      MarketItem(
        title: "Local VPN Setup",
        price: "10 MSH",
        distance: "Nearby",
        image: "assets/images/item3.jpg",
        seller: "SafeRoute",
        category: "Services",
      ),
    ];
  }
}

class MarketItem {
  final String title;
  final String price;
  final String distance;
  final String image;
  final String seller;
  final String category;

  MarketItem({
    required this.title,
    required this.price,
    required this.distance,
    required this.image,
    required this.seller,
    required this.category,
  });
}
