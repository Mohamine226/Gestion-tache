import 'package:flutter/material.dart';
import 'package:sibiapp/page/GererStock.dart';
import 'package:sibiapp/page/ImagePlein.dart';
import 'package:sibiapp/page/MagasinPage.dart';
import 'package:sibiapp/page/VoirToutRupture.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  // --- Données fictives JSON ---
  final Map<String, dynamic> dashboardData = {
    "totalProduits": 84,
    "produitsDefaut": 9,
    "stocksRupture": [
      {"produit": "Coca-Cola", "quantite": 2, "prix": "500 CFA",
        "image": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"},
      {"produit": "Riz 5kg", "quantite": 1, "prix": "3 000 CFA", "image":""},
      {"produit": "Savon Lux", "quantite": 0, "prix": "1 200 CFA",
        "image": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"},
      {"produit": "Tomates", "quantite": 8, "prix": "2 000 CFA",
        "image": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"},
      {"produit": "T-shirt Bleu", "quantite": 12, "prix": "12 000 CFA",
        "image": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"},
      {"produit": "Pain", "quantite": 15, "prix": "2 500 CFA", "image":""},
      {"produit": "T-shirt Bleu", "quantite": 12, "prix": "12 000 CFA",
        "image": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"},
      {"produit": "Pain", "quantite": 5, "prix": "2 500 CFA", "image":""},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stocks",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.store),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Carte Produits en stock
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.receipt_long, color: Colors.white),
                      const SizedBox(width: 8),
                      const Text(
                        "Produits en Stock",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.warning_amber, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        "${dashboardData['produitsDefaut']} en Rupture!",
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // --- Ligne blanche de séparation ---
                  const Divider(color: Colors.white, thickness: 0),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Text(
                        "${dashboardData['totalProduits']} Produits",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MagasinPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- Liste des produits ---
            Expanded(
              flex: 3,
              child: Card(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Les produits en rupture",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: dashboardData['stocksRupture'].isEmpty
                          ? const Center(
                        child: Text(
                          "Aucun produit en rupture",
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      )
                          : ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: dashboardData['stocksRupture']
                            .map<Widget>((stock) => _stockItem(
                          stock['produit'],
                          stock['prix'],
                          stock['quantite'],
                          stock['image'],
                        ))
                            .toList(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VoirToutRupture(
                              stock: List<Map<String, dynamic>>.from(
                                  dashboardData['stocksRupture']),
                            ),
                          ),
                        );
                      },
                      child: const Text("Voir tout"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Bouton ajouter produit ---
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GererStock()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  "Gérer le Stock",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Produit (style simple comme _saleItem) ---
  Widget _stockItem(String produit, String prix, int quantite, String? imageUrl) {
    Color badgeColor;
    if (quantite <= 2) {
      badgeColor = Colors.red;
    } else if (quantite <= 10) {
      badgeColor = Colors.orange;
    } else {
      badgeColor = Colors.green;
    }

    return ListTile(
      dense: true,
      leading: (imageUrl != null && imageUrl.isNotEmpty)
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
          radius: 20,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: NetworkImage(imageUrl),
        ),
      )
          : const Icon(Icons.inventory, color: Colors.blue, size: 25),

      title: Text(produit, style: const TextStyle(fontSize: 14)),
      subtitle: Text(prix, style: const TextStyle(fontSize: 13)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
        ],
      ),
    );
  }
}