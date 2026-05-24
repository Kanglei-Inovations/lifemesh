import 'package:get/get.dart';

class FeedController extends GetxController {
  var posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockPosts();
  }

  void loadMockPosts() {
    posts.value = [
      Post(
        username: "Nexus-Alpha",
        content:
            "Just joined the mesh! The connection is incredibly stable here in the park. 🌐",
        time: "2m ago",
        distance: "15m",
        likes: 12,
        comments: 3,
      ),
      Post(
        username: "Cyber_Punk",
        content:
            "Anyone have the documentation for the new local node protocol? Looking to relay some data. 💻",
        time: "15m ago",
        distance: "45m",
        likes: 5,
        comments: 8,
      ),
      Post(
        username: "MeshMaster",
        content:
            "Check out this view from the rooftop! No internet needed to share this. 📸",
        time: "1h ago",
        distance: "120m",
        likes: 42,
        comments: 5,
        hasImage: true,
      ),
    ];
  }
}

class Post {
  final String username;
  final String content;
  final String time;
  final String distance;
  final int likes;
  final int comments;
  final bool hasImage;

  Post({
    required this.username,
    required this.content,
    required this.time,
    required this.distance,
    required this.likes,
    required this.comments,
    this.hasImage = false,
  });
}
