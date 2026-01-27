import 'package:flutter/material.dart';
import 'package:sibiapp/page/ImagePlein.dart';
import 'package:sibiapp/page/VoirTodayVentes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- Données fictives ---
  final Map<String, dynamic> dashboardData = {
    "ventesJour": 82500,
    "nombreVentes": 10000,
    "totalMois": 540000,
    "stocks": [
      {"produit": "Savon Lux", "quantite": 0, "image": ""},
      {"produit": "Coca-Cola", "quantite": 2,
        "image": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"},
      {"produit": "Riz 5kg", "quantite": 100, "image": ""},
    ],
    "ventesRecentes": [
      {"produit": "Pain x 3", "prix": "1 500 CFA", "heure": "09:45",
        "image": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"},
      {"produit": "Tomates x 5", "prix": "2 000 CFA", "heure": "09:45",
        "image": "https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg"},
      {"produit": "Lait x 2", "prix": "1 800 CFA", "heure": "09:15", "image": ""},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil",
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
            // --- Cartes statistiques ---
            Row(
              children: [
                _infoCard(
                  Icons.attach_money,
                  "Total du jour",
                  "${dashboardData['ventesJour']} CFA",
                  Colors.green,
                ),
                _infoCard(
                  Icons.shopping_cart_rounded,
                  "Produits ventes:",
                  "${dashboardData['nombreVentes']} ",
                  Colors.blue,
                ),
                _infoCard(
                  Icons.bar_chart,
                  "Total du Mois",
                  "${dashboardData['totalMois']} CFA",
                  Colors.orange,
                ),
              ],
            ),

            const SizedBox(height: 5),

            // --- Alertes stock ---
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alertes Stock Faible",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 0),
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
                        :  ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: dashboardData['stocks']
                          .map<Widget>((stock) =>
                          _stockAlert(
                              stock['produit'],
                              stock['quantite'],
                              stock['image']))
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text("Gérer le Stock"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // --- Dernières ventes ---
            Expanded(
              flex: 3,
              child: Card(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Dernières ventes",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: dashboardData['ventesRecentes'].isEmpty
                          ? const Center(
                        child: Text(
                          "Aucun produit vendu",
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      )
                          : ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: dashboardData['ventesRecentes']
                            .map<Widget>((vente) => _saleItem(
                            vente['produit'],
                            vente['prix'],
                            vente['heure'],
                            vente['image']))
                            .toList(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VoirTout(
                              ventes: List<Map<String, dynamic>>.from(
                                  dashboardData['ventesRecentes']),
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

            const SizedBox(height: 8),

            // --- Bouton ajouter vente ---
            SizedBox(
              width: double.infinity,
              height: 35,
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
          ],
        ),
      ),
    );
  }

  // --- Carte statistique ---
  Widget _infoCard(
      IconData icon, String title, String value, Color color) {
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
                Expanded( // permet au texte de prendre l'espace restant
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                    overflow: TextOverflow.ellipsis, // coupe avec "..."
                    maxLines: 2,                     // reste sur une seule ligne
                    softWrap: true,                 // interdit le retour à la ligne
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

      /// 🖼️ IMAGE PRODUIT À GAUCHE
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

      /// 📝 TEXTE AU CENTRE
      title: Text(
        produit,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(fontSize: 12),
      ),

      /// ⚠️ ICÔNE D’ALERTE À DROITE
      trailing: Icon(icon, color: color),
    );
  }


  // --- Vente ---
  Widget _saleItem(String produit, String prix, String heure, String? imageUrl) {
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
          radius: 18,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: NetworkImage(imageUrl),
        ),
      )
          : const Icon(Icons.shopping_cart_rounded, color: Colors.blue),

      title: Text(produit, style: const TextStyle(fontSize: 14)),
      trailing: Text(
        "$prix • $heure",
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}