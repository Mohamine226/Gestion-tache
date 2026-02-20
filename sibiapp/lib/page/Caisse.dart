import 'package:flutter/material.dart';
import 'package:sibiapp/page/Voirmobile.dart';

class CaissePage extends StatefulWidget {
  const CaissePage({super.key});

  @override
  State<CaissePage> createState() => _CaissePageState();
}

class _CaissePageState extends State<CaissePage> {
  // --- Données fictives JSON ---
  final Map<String, dynamic> soldeData = {
    "soldeActuel": "190,000 CFA",
    "ventesJour": "50,000 CFA",
    "depotsJour": "20,000 CFA",
    "retraitsJour": "5,000 CFA",
  };

  final Map<String, dynamic> beneficeData = {
    "beneficeJour": "55,000 CFA",
    "details": "50,000 (ventes) - 15,000 (retraits)",
  };

  final List<Map<String, dynamic>> transactions = [
    {
      "type": "Dépôt",
      "service": "Mobile ",
      "nom": "Issa Traoré",
      "cin": "B102152020",
      "montant": "+10 000 CFA",
      "heure": "20 min"
    },
    {
      "type": "Retrait",
      "service": "5584522 ",
      "nom": "Awa Ouédraogo",
      "cin": "B102152020",
      "montant": "-2 000 CFA",
      "heure": "1h"
    },
    {
      "type": "Dépôt",
      "service": "Mov",
      "nom": "Moussa Kaboré",
      "cin": "B102152020",
      "montant": "+5 000 CFA",
      "heure": "3h"
    },
    {
      "type": "Retrait",
      "service": "Orange",
      "nom": "Salif Diallo",
      "cin": "B102152020",
      "montant": "-3 000 CFA",
      "heure": "6h"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final visibleTransactions = transactions.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Caisse",
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
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Carte Solde actuel ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 26,
                      ),
                      const SizedBox(width: 1),
                      const Text(
                        "Solde Actuel",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // 👉 action à exécuter (ex: navigation vers une autre page)
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(soldeData["soldeActuel"],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      _miniBloc("+ Ventes Aujourd'hui",
                          soldeData["ventesJour"], Colors.green.shade600),
                      const SizedBox(width: 8),
                      _miniBloc("+ Dépôts Aujourd'hui",
                          soldeData["depotsJour"], Colors.blue.shade600),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- Carte Bénéfice du jour ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.attach_money,
                      color: Colors.orange, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Bénéfice du jour",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(beneficeData["beneficeJour"],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                        const SizedBox(height: 2),
                        Text(beneficeData["details"],
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // action à exécuter
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),


            // --- Historique d'aujourd'hui ---
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Historique d'aujourd'hui",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),


                  // --- Liste non scrollable (3 éléments) ---
                  transactions.isEmpty
                      ? const Center(
                    child: Text(
                      "Aucun retrait ni dépôt aujourd'hui",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  )
                      : Column(
                    children: [
                      for (var tx in visibleTransactions)
                        ListTile(
                          leading: Icon(
                            tx["type"] == "Dépôt"
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: tx["type"] == "Dépôt" ? Colors.green : Colors.red,
                          ),
                          title: Text("${tx['type']}: ${tx['service']}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${tx['nom']} - ${tx['cin']}",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          trailing: Text("${tx['montant']}\n${tx['heure']}",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ),

                      // --- Bouton Voir plus ---
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Voirmobile()),
                          );
                        },
                        child: const Text("Voir plus"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- Boutons d’action ---
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_downward),
                    label: const Text("Dépôt"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_upward),
                    label: const Text("Retrait"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniBloc(String title, String amount, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 11)),
            const SizedBox(height: 4),
            Text(amount,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
