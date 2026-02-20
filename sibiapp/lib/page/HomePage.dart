import 'package:flutter/material.dart';
import 'package:sibiapp/page/ImagePlein.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- Données fictives ---
  final Map<String, dynamic> dashboardData = {
    "nombreDepot": 82500,
    "nombreVentes": 10000,
    "nombreRetrait": 540000,
    "soldeJour": 1000000,
    "stocks": [
      {"produit": "Savon Lux", "quantite": 0, "image": ""},
      {
        "produit": "Coca-Cola",
        "quantite": 2,
        "image":
        "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"
      },
      {"produit": "Riz 5kg", "quantite": 100, "image": ""},
      {"produit": "Pomades", "quantite": 800, "image": ""},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Accueil",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [

            Row(
              children: [
                _infoCard(
                  Icons.attach_money,
                  "Solde d'aujourd'hui",
                  "${dashboardData['soldeJour']} CFA",
                  Colors.orange,
                ),
                _infoCard(
                  Icons.shopping_cart_rounded,
                  "Ventes d'aujourd'hui:",
                  "${dashboardData['nombreVentes']} Produits",
                  Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 15),
            // --- Cartes statistiques ---
            Row(
              children: [
                _infoCard(
                  Icons.arrow_downward,
                  "Nombres de dépot",
                  "${dashboardData['nombreDepot']}",
                  Colors.green,
                ),
                _infoCard(
                  Icons.shopping_cart_rounded,
                  "Produits ventes:",
                  "${dashboardData['nombreVentes']} ",
                  Colors.green,
                ),
                _infoCard(
                  Icons.arrow_upward,
                  "Nombre de retrait",
                  "${dashboardData['nombreRetrait']}",
                  Colors.green,
                ),
              ],
            ),





            const SizedBox(height: 5),

            // --- Alertes stock avec bordure ---
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Alertes Stock Faible",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: dashboardData['stocks'].isEmpty
                          ? const Center(
                        child: Text(
                          "Aucun produit",
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      )
                          : ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: dashboardData['stocks']
                            .map<Widget>((stock) => _stockAlert(
                            stock['produit'],
                            stock['quantite'],
                            stock['image']))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Bouton ajouter vente ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text(
                  "Ajouter une Vente",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Boutons Dépôt et Retrait côte à côte ---
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text("Dépôt"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_upward),
                    label: const Text("Retrait"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  // --- Carte statistique ---
  Widget _infoCard(IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 24),
                const SizedBox(width: 1),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white, thickness: 0),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Alerte stock ---
  Widget _stockAlert(String produit, int quantite, String? imageUrl) {
    IconData icon;
    Color color;
    String message;

    if (quantite == 0) {
      icon = Icons.error;
      color = Colors.red;
      message = "Stock épuisé";
    } else if (quantite == 1) {
      icon = Icons.warning;
      color = Colors.orange;
      message = "Presque épuisé";
    } else if (quantite > 1 && quantite <= 10) {
      icon = Icons.warning_amber;
      color = Colors.orange;
      message = "Stock faible ($quantite)";
    } else {
      icon = Icons.check_circle;
      color = Colors.green;
      message = "Stock disponible ($quantite)";
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
      title: Text(
        produit,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Icon(icon, color: color),
    );
  }
}