enum SizeFont {
  small(0.8),
  normal(1.0),
  large(1.2),
  extraLarge(1.5);

  const SizeFont(this.value);
  final double value;
  factory SizeFont.fromString(String? value) {
    return SizeFont.values
        .firstWhere((e) => e.name == value, orElse: () => SizeFont.normal);
  }
}

// enum SizeFont {
//   small('small', 0.8),
//   normal('normal', 1.0),
//   large('large', 1.2),
//   extraLarge('extraLarge', 1.5);

//   final String name;
//   final double scaleFactor;

//   const SizeFont(this.name, this.scaleFactor);
// }