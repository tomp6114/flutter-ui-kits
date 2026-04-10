import 'package:flutter/material.dart';

/// A set of panels providing FAQ-style providing expanding and collapsing mappings natively.
class AccordionKit extends StatelessWidget {
  final List<AccordionItem> items;
  final bool multipleExpanded;

  const AccordionKit({
    super.key,
    required this.items,
    this.multipleExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Theme.of(context).dividerColor),
          ),
          child: ExpansionTile(
            title: Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: item.content,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class AccordionItem {
  final String title;
  final Widget content;

  AccordionItem({required this.title, required this.content});
}
