import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final Map<String, dynamic> dashboardData = {
    "totalJour": 2500,
    "nombreVentes": 10000,
    "totalMois": 50000,
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistiques",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.calendar_month_rounded))
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
                    "Total du jour",
                    "${dashboardData['totalJour']} CFA" ,
                    Colors.green,
                  ),
                  _infoCard(
                    Icons.attach_money,
                    "Produits vendus",
                    "${dashboardData['nombreVentes']}" ,
                    Colors.blue,
                  ),
                  _infoCard(
                    Icons.attach_money,
                    "Total du Mois",
                    "${dashboardData['totalMois']} CFA" ,
                    Colors.orange,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  _infoCard(
                    Icons.attach_money,
                    "Produits vendus",
                    "${dashboardData['nombreVentes']}" ,
                    Colors.blue,
                  ),
                  _infoCard(
                    Icons.attach_money,
                    "Total du Mois",
                    "${dashboardData['totalMois']} CFA" ,
                    Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }

  Widget _infoCard ( IconData icon, String title, String value, Color color ) {
    return Expanded(
      child: Container(
        height: 95,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
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
            )
          ],
        ),
      ),
    );
  }
}
