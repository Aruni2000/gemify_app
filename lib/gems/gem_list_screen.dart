import 'package:flutter/material.dart';
import '../../../../models/gem.dart';
import 'widgets/gem_card.dart';

class GemListScreen extends StatelessWidget {
  const GemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Empty gem list for now
    final List<Gem> gemList = [];

    return Scaffold(
      appBar: AppBar(title: const Text("Gem Inventory")),
      body: gemList.isEmpty
          ? const Center(child: Text("No gems added yet. Tap + to add."))
          : ListView.builder(
              itemCount: gemList.length,
              itemBuilder: (context, index) {
                final gem = gemList[index]; // ✅ gem is type Gem
                return GemCard(gem: gem); // ✅ matches constructor
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addGem");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
