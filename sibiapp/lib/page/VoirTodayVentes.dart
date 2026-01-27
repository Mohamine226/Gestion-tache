import 'package:flutter/material.dart';
import 'package:sibiapp/page/ImagePlein.dart';

class VoirTout extends StatefulWidget {
  final List<Map<String, dynamic>> ventes;

  const VoirTout({super.key, required this.ventes});

  @override
  State<VoirTout> createState() => _VoirToutState();
}

class _VoirToutState extends State<VoirTout> {
  String query = "";
  bool showSearch = false; // contrôle l’affichage de la barre de recherche

  @override
  Widget build(BuildContext context) {
    // filtrer les ventes selon la recherche
    final filtered = widget.ventes.where((vente) {
      final produit = vente['produit'].toString().toLowerCase();
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
            : const Text("Toutes les ventes"),
        actions: [
          IconButton(
            icon: Icon(showSearch ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
                if (!showSearch) query = ""; // reset recherche si on ferme
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final vente = filtered[index];
          return ListTile(
            leading: (vente['image'] != null && vente['image'].toString().isNotEmpty)
                ? GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImagePlein(imageUrl: vente['image']),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: NetworkImage(vente['image']),
              ),
            )
                : const Icon(Icons.shopping_cart_rounded, color: Colors.blue),

            title: Text(vente['produit']),
            trailing: Text("${vente['prix']} • ${vente['heure']}"),
          );
        },
      ),
    );
  }
}