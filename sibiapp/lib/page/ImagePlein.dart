import 'package:flutter/material.dart';

// --- Écran image plein écran ---
class ImagePlein extends StatelessWidget {
  final String imageUrl;
  const ImagePlein({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Aperçu"),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 80);
          },
        ),
      ),
    );
  }
}