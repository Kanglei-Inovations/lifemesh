import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FileSharingController extends GetxController {
  var selectedFiles = <FileItem>[].obs;
  var isTransferring = false.obs;
  var transferProgress = 0.0.obs;

  void loadMockFiles() {
    selectedFiles.value = [
      FileItem(
        name: "Project_Mesh.pdf",
        size: "2.4 MB",
        type: "PDF",
        icon: Icons.picture_as_pdf,
      ),
      FileItem(
        name: "Neural_Link_Proto.zip",
        size: "45 MB",
        type: "Archive",
        icon: Icons.folder_zip,
      ),
      FileItem(
        name: "Identity_Core.svg",
        size: "120 KB",
        type: "Image",
        icon: Icons.image,
      ),
    ];
  }

  void startTransfer() {
    isTransferring.value = true;
    transferProgress.value = 0.0;

    // Simulate transfer
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      transferProgress.value += 0.02;
      if (transferProgress.value >= 1.0) {
        isTransferring.value = false;
        return false;
      }
      return true;
    });
  }
}

class FileItem {
  final String name;
  final String size;
  final String type;
  final IconData icon;

  FileItem({
    required this.name,
    required this.size,
    required this.type,
    required this.icon,
  });
}
