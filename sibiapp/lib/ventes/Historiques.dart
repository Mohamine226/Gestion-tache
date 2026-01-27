import 'package:flutter/material.dart';

class Historiques extends StatefulWidget {
  const Historiques({super.key});

  @override
  State<Historiques> createState() => _HistoriquesState();
}

class _HistoriquesState extends State<Historiques> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historiques des ventes"),
      ),

        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Divider(color: Colors.black, thickness: 1),
              _actionButton(
                "Les ventes d'hier",
                onTap: () {
                  print("Bouton 'Les ventes d'hier' cliqué");
                },
              ),
              const Divider(color: Colors.black, thickness: 1),
              _actionButton(
                "Les ventes d'hier",
                onTap: () {
                  print("Bouton 'Les ventes d'hier' cliqué");
                },
              ),
              const Divider(color: Colors.black, thickness: 1),
              _actionButton(
                "Les ventes d'hier",
                onTap: () {
                  print("Bouton 'Les ventes d'hier' cliqué");
                },
              ),
              const Divider(color: Colors.black, thickness: 1),
              _actionButton(
                "Les ventes d'hier",
                onTap: () {
                  print("Bouton 'Les ventes d'hier' cliqué");
                },
              ),
              const Divider(color: Colors.black, thickness: 1),
              _actionButton(
                "Les ventes d'hier",
                onTap: () {
                  print("Bouton 'Les ventes d'hier' cliqué");
                },
              ),
              const Divider(color: Colors.black, thickness: 1),
              _actionButton(
                "Les ventes d'hier",
                onTap: () {
                  print("Bouton 'Les ventes d'hier' cliqué");
                },
              ),
            ],
          ),
        )
    );
  }
}

Widget _actionButton( String label, {required VoidCallback onTap}) {
  return ListTile(
    title: Text(
      label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20
      ),
    ),
    onTap: onTap,
  );
}
