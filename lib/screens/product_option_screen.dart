import 'package:flutter/material.dart';
import 'package:product_variants_app/screens/product_variants_screen.dart';

class ProductOptionScreen extends StatefulWidget {
  @override
  _ProductOptionScreenState createState() => _ProductOptionScreenState();
}

class _ProductOptionScreenState extends State<ProductOptionScreen> {
  final List<String> availableOptions = ['Size', 'Color', 'Material'];
  final TextEditingController optionValueController = TextEditingController();
  String selectedOption = 'Size';
  Map<String, List<String>> productOptions = {};
  String? optionToEdit; // Store the option to be edited

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Option'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown menu for product option type
            Container(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                value: selectedOption,
                decoration: InputDecoration(
                  labelText: 'Select Option Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: availableOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            // Text field for option value input
            TextField(
              controller: optionValueController,
              decoration: InputDecoration(
                labelText: optionToEdit == null
                    ? 'Option Value (e.g., Small, Red, Cotton)'
                    : 'Edit Option Value',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    if (optionToEdit != null) {
                      // Edit the existing value
                      List<String> optionValues = productOptions[selectedOption]!;
                      int index = optionValues.indexOf(optionToEdit!);
                      optionValues[index] = value;
                      optionToEdit = null; // Clear after editing
                    } else {
                      // Add new value
                      if (productOptions.containsKey(selectedOption)) {
                        productOptions[selectedOption]?.add(value);
                      } else {
                        productOptions[selectedOption] = [value];
                      }
                    }
                    optionValueController.clear();
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            // Displays selected options as cards
            if (productOptions.isNotEmpty) ...[
              const Text(
                'Selected Options:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: productOptions.entries.map((entry) {
                    return Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${entry.key}:',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Wrap(
                                spacing: 8.0,
                                children: entry.value.map((optionValue) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        optionValueController.text = optionValue;
                                        selectedOption = entry.key; // Set option type
                                        optionToEdit = optionValue; // Set value for editing
                                      });
                                    },
                                    child: Chip(
                                      label: Text(optionValue),
                                      deleteIcon: const Icon(Icons.delete),
                                      onDeleted: () {
                                        setState(() {
                                          productOptions[entry.key]?.remove(optionValue);
                                          if (productOptions[entry.key]?.isEmpty ?? false) {
                                            productOptions.remove(entry.key);
                                          }
                                        });
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductVariantScreen(
                      productOptions: productOptions,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Generate Variants'),
            ),
          ],
        ),
      ),
    );
  }
}
