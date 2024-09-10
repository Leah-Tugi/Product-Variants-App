
class ProductVariant {
  final Map<String, String> options;
  bool isSelected;

  ProductVariant({
    required this.options,
    this.isSelected = false,
  });

  // Helper method to generate the display name of the variant
  String get variantName {
    return options.values.join(' / ');
  }

  // method to generate variants from a map of product options
  static List<ProductVariant> generateVariants(Map<String, List<String>> options) {
    List<ProductVariant> variants = [];

    List<Map<String, String>> combinations = [{}];

    options.forEach((optionName, values) {
      List<Map<String, String>> newCombinations = [];
      for (var combination in combinations) {
        for (var value in values) {
          Map<String, String> newCombination = Map<String, String>.from(combination);
          newCombination[optionName] = value;
          newCombinations.add(newCombination);
        }
      }
      combinations = newCombinations;
    });

    // Convert combinations into ProductVariant instances
    for (var combination in combinations) {
      variants.add(ProductVariant(options: combination));
    }

    return variants;
  }
}
