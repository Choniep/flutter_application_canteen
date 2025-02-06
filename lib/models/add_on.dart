class AddOn {
  final String name;
  final double price;

  AddOn({
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}
