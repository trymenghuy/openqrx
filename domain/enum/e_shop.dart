enum EShop {
  restaurant('Restaurant'),
  other('other');

  const EShop(this.value);
  final String value;
  factory EShop.fromString(String? ln) =>
      EShop.values.firstWhere((e) => e.value == ln, orElse: () => EShop.other);
}
