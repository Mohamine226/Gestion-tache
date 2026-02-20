import 'package:flutter/material.dart';
import 'package:sibiapp/page/ImagePlein.dart';
import 'package:sibiapp/page/ModifieProduit.dart';

class GererStock extends StatefulWidget {
  const GererStock({super.key});

  @override
  State<GererStock> createState() => _GererStockState();
}

class _GererStockState extends State<GererStock> {
  final List<Map<String, dynamic>> produits = [
    {
      "nom": "Tomates",
      "prix": 100,
      "stock": 15,
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg",
    },
    {
      "nom": "Pain",
      "prix": 500,
      "stock": 0,
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/0/0f/Bread.jpg",
    },
    {
      "nom": "Savon Lux",
      "prix": 300,
      "stock": 5,
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/3/3d/Soap_Bar.jpg",
    },
    {
      "nom": "T-shirt Bleu",
      "prix": 12000,
      "stock": 7,
      "image":
      "https://upload.wikimedia.org/wikipedia/commons/4/4d/Tshirt.jpg",
    },
  ];

  String query = "";
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    // --- Filtrage : uniquement produits en rupture ---
    final ruptureProduits = produits.where((p) => p["stock"] <= 15).toList();

    // --- Filtrage dynamique avec recherche ---
    final filteredProduits = ruptureProduits
        .where((p) =>
        p["nom"].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? const Text("Gérer Stock (Rupture)")
            : TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Rechercher un produit en rupture...",
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.black),
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  query = ""; // réinitialise la recherche
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),
      body: filteredProduits.isEmpty
          ? const Center(
        child: Text(
          "Aucun produit en rupture trouvé",
          style: TextStyle(fontSize: 16, color: Colors.black45),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: filteredProduits.length,
        itemBuilder: (context, index) {
          final produit = filteredProduits[index];
          final imageUrl = produit["image"];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: imageUrl != null && imageUrl.toString().isNotEmpty
                  ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ImagePlein(imageUrl: imageUrl),
                    ),
                  );
                },
                child: Image.network(
                  imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.inventory,
                        size: 32, color: Colors.grey);
                  },
                ),
              )
                  : const Icon(Icons.inventory,
                  size: 32, color: Colors.grey),
              title: Text(produit["nom"]),
              subtitle: Text(
                "${produit["prix"]} CFA\n${produit["stock"]} en stock",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ModifieProduit(produit: produit),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}