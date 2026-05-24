import 'dart:convert';
import 'package:cryptography/cryptography.dart';

class CryptoService {
  late final SecretKey _secretKey;
  final _cipher = Chacha20.poly1305Aead();

  // In a real production mesh, this would be negotiated per peer or via DH.
  // For the offline prototype foundation, we use a shared network key.
  Future<void> init() async {
    // Generate a static key for prototype. In production, use X25519 for key exchange.
    final hash = await Sha256().hash(utf8.encode('lifemesh_offline_mesh_network'));
    _secretKey = SecretKey(hash.bytes);
  }

  Future<List<int>> encryptMessage(Map<String, dynamic> payload) async {
    final jsonStr = jsonEncode(payload);
    final clearText = utf8.encode(jsonStr);

    final secretBox = await _cipher.encrypt(
      clearText,
      secretKey: _secretKey,
    );

    return secretBox.concatenation();
  }

  Future<Map<String, dynamic>?> decryptMessage(List<int> encryptedBytes) async {
    try {
      final secretBox = SecretBox.fromConcatenation(
        encryptedBytes,
        nonceLength: _cipher.macAlgorithm.macLength,
        macLength: _cipher.macAlgorithm.macLength,
      );

      final clearText = await _cipher.decrypt(
        secretBox,
        secretKey: _secretKey,
      );

      final jsonStr = utf8.decode(clearText);
      return jsonDecode(jsonStr) as Map<String, dynamic>?;
    } catch (e) {
      print("Encryption Layer: Decryption failed - $e");
      return null;
    }
  }
}
