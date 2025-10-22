import 'package:flutter/material.dart';

class GemInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const GemInfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
    );
  }
}
