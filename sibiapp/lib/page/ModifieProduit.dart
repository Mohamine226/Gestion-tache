import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:sibiapp/widget/Input.dart'; // 👉 ton widget Input

class ModifieProduit extends StatefulWidget {
  final Map<String, dynamic> produit;

  const ModifieProduit({super.key, required this.produit});

  @override
  State<ModifieProduit> createState() => _ModifieProduitState();
}

class _ModifieProduitState extends State<ModifieProduit> {
  late TextEditingController prixController;
  late TextEditingController stockController;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    prixController =
        TextEditingController(text: widget.produit["prix"].toString());
    stockController =
        TextEditingController(text: widget.produit["stock"].toString());
  }

  @override
  void dispose() {
    prixController.dispose();
    stockController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Prendre une photo"),
                onTap: () async {
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choisir depuis la galerie"),
                onTap: () async {
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modifier ${widget.produit["nom"]}")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- Champ prix ---
            Input(
              label: "Prix (CFA)",
              hint: "Entrez le prix",
              controller: prixController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            // --- Champ stock ---
            Input(
              label: "Stock",
              hint: "Entrez la quantité en stock",
              controller: stockController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            _imageFile != null
                ? Image.file(
              _imageFile!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            )
                : (widget.produit["image"] != null && widget.produit["image"].toString().isNotEmpty
                ? Image.network(
              widget.produit["image"],
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.shopping_bag, size: 80, color: Colors.grey);
              },
            )
                : const Icon(Icons.shopping_bag, size: 80, color: Colors.grey)),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text("Choisir une image"),
              onPressed: _pickImage,
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Enregistrer"),
              onPressed: () {
                setState(() {
                  widget.produit["prix"] =
                      int.tryParse(prixController.text) ?? 0;
                  widget.produit["stock"] =
                      int.tryParse(stockController.text) ?? 0;
                  widget.produit["image"] =
                  _imageFile != null ? _imageFile!.path : widget.produit["image"];
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Produit mis à jour")),
                );
                Navigator.pop(context, widget.produit);
              },
            ),
          ],
        ),
      ),
    );
  }
}