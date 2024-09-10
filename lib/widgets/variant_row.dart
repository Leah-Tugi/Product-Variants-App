import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VariantRow extends StatelessWidget {
  final String variantName;
  final bool isSelected;
  final Function(bool?) onChecked;

  VariantRow({required this.variantName, required this.isSelected, required this.onChecked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: onChecked,
              ),
              Expanded(
                child: Text(variantName, style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Price (\$)'),
                  keyboardType: TextInputType.number,
                  enabled: isSelected, // Enable editing only if checked
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  enabled: isSelected, // Enable editing only if checked
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'SKU'),
                  enabled: isSelected, // Enable editing only if checked
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
