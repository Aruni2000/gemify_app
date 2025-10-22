import 'package:flutter/material.dart';
import '../../../../models/gem.dart';

class GemCard extends StatelessWidget {
  final Gem gem;

  const GemCard({super.key, required this.gem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(gem.gemName),
        subtitle: Text("Code: ${gem.gemCode}"),
        trailing: Text("\$${gem.totalCost}"),
        onTap: () {
          // Navigate to gem detail screen later
        },
      ),
    );
  }
}
