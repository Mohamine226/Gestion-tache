import 'package:flutter/material.dart';
import 'package:sibiapp/page/ImagePlein.dart';

class VoirToutRupture extends StatefulWidget {
  final List<Map<String, dynamic>> stock;

  const VoirToutRupture({super.key, required this.stock});

  @override
  State<VoirToutRupture> createState() => _VoirToutRuptureState();
}

class _VoirToutRuptureState extends State<VoirToutRupture> {
  String query = "";
  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    final filtered = widget.stock.where((stock) {
      final produit = stock['produit'].toString().toLowerCase();
      return produit.contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: showSearch
            ? TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Rechercher un produit...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54),
          ),
          style: const TextStyle(color: Colors.black87),
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
        )
            : const Text("Tous les produits en rupture"),
        actions: [
          IconButton(
            icon: Icon(showSearch ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
                if (!showSearch) query = "";
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final stock = filtered[index];
          final produit = stock['produit'] ?? "";
          final prix = stock['prix'] ?? "";
          final quantite = stock['quantite'] ?? 0;
          final imageUrl = stock['image'] ?? "";

          Color badgeColor;
          if (quantite <= 2) {
            badgeColor = Colors.red;
          } else if (quantite <= 10) {
            badgeColor = Colors.orange;
          } else {
            badgeColor = Colors.green;
          }

          return ListTile(
            leading: (imageUrl.isNotEmpty)
                ? GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImagePlein(imageUrl: imageUrl),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: NetworkImage(imageUrl),
              ),
            )
                : const Icon(Icons.inventory, color: Colors.blue, size: 25),
            title: Text(produit, style: const TextStyle(fontSize: 14)),
            subtitle: Text(prix, style: const TextStyle(fontSize: 13)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$quantite restants",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}