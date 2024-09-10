import 'package:flutter/material.dart';
import '../models/product_variant_model.dart';
import '../widgets/variant_row.dart';

class ProductVariantScreen extends StatefulWidget {
  final Map<String, List<String>> productOptions;

  ProductVariantScreen({required this.productOptions});

  @override
  _ProductVariantScreenState createState() => _ProductVariantScreenState();
}

class _ProductVariantScreenState extends State<ProductVariantScreen> {
  List<ProductVariant> variants = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    // Generate variants using the ProductVariant model
    variants = ProductVariant.generateVariants(widget.productOptions);
  }

  // Toggle the selection of all variants
  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      // Update the selection status for all variants
      for (var variant in variants) {
        variant.isSelected = selectAll;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Product Variants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Variants: ${variants.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Row for "Select All" checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select All',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Checkbox(
                  value: selectAll,
                  onChanged: toggleSelectAll,
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: variants.length,
                itemBuilder: (context, index) {
                  String variantName = variants[index].variantName;
                  return VariantRow(
                    variantName: variantName,
                    isSelected: variants[index].isSelected,
                    onChecked: (value) {
                      setState(() {
                        variants[index].isSelected = value!;
                        // If any checkbox is unchecked, set "selectAll" to false
                        if (!value) {
                          selectAll = false;
                        }
                        // If all checkboxes are checked, set "selectAll" to true
                        else if (variants.every((variant) => variant.isSelected)) {
                          selectAll = true;
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
