import 'package:flutter/material.dart';

class Voirmobile extends StatelessWidget {
  const Voirmobile({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Données fictives JSON ---
    final List<Map<String, dynamic>> allTransactions = [
      {
        "type": "Dépôt",
        "service": "Mobile Money",
        "nom": "Issa Traoré",
        "cin": "B102152020",
        "montant": "+10 000 CFA",
        "heure": "20 min"
      },
      {
        "type": "Retrait",
        "service": "64148725",
        "nom": "Awa Ouédraogo",
        "cin": "B102152020",
        "montant": "-2 000 CFA",
        "heure": "1h"
      },
      {
        "type": "Dépôt",
        "service": "Mobile Money",
        "nom": "Moussa Kaboré",
        "cin": "B102152020",
        "montant": "+5 000 CFA",
        "heure": "3h"
      },
      {
        "type": "Retrait",
        "service": "Mobile Money",
        "nom": "Salif Diallo",
        "cin": "B102152020",
        "montant": "-3 000 CFA",
        "heure": "6h"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique complet"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Exemple simple : afficher une boîte de dialogue de recherche
              showSearch(
                context: context,
                delegate: TransactionSearchDelegate(allTransactions),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: allTransactions.isEmpty
            ? const Center(
          child: Text(
            "Aucun retrait ni dépôt aujourd'hui",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        )
            : ListView.builder(
          itemCount: allTransactions.length,
          itemBuilder: (context, index) {
            final tx = allTransactions[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Icon(
                  tx["type"] == "Dépôt"
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: tx["type"] == "Dépôt"
                      ? Colors.green
                      : Colors.red,
                ),
                title: Text("${tx['type']}: ${tx['service']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tx['nom']} - ${tx['cin']}",
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Text("${tx['montant']}\n${tx['heure']}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            );
          },
        ),
      ),
    );
  }
}


// --- Delegate pour la recherche ---
class TransactionSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> transactions;

  // 👉 Ici on change le texte de la barre de recherche
  @override
  String? get searchFieldLabel => "Recherche";


  TransactionSearchDelegate(this.transactions);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black,),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black,),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = transactions
        .where((tx) =>
    tx["nom"].toLowerCase().contains(query.toLowerCase()) ||
        tx["service"].toLowerCase().contains(query.toLowerCase()) ||
        tx["montant"].toLowerCase().contains(query.toLowerCase()) ||
        tx["heure"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text("Aucun résultat trouvé"));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final tx = results[index];
        return ListTile(
          leading: Icon(
            tx["type"] == "Dépôt" ? Icons.arrow_downward : Icons.arrow_upward,
            color: tx["type"] == "Dépôt" ? Colors.green : Colors.red,
          ),
          title: Text("- ${tx['type']} (${tx['service']})"),
          subtitle: Text("${tx['nom']} - ${tx['cin']}"),
          trailing: Text("${tx['montant']} • ${tx['heure']}"),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = transactions
        .where((tx) =>
    tx["nom"].toLowerCase().contains(query.toLowerCase()) ||
        tx["service"].toLowerCase().contains(query.toLowerCase()) ||
        tx["montant"].toLowerCase().contains(query.toLowerCase()) ||
        tx["heure"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final tx = suggestions[index];
        return ListTile(
          title: Text("- ${tx['type']} ${tx['service']}"),
          subtitle: Text("${tx['nom']} - ${tx['cin']}"),
          onTap: () {
            query = tx["nom"];
            showResults(context);
          },
        );
      },
    );
  }
}