enum ERole {
  owner('owner'),
  admin('admin'),
  editor('editor'),
  creator('creator'),
  viewer('viewer'),
  none('none');

  const ERole(this.value);
  final String value;
  factory ERole.fromString(String? ln) =>
      ERole.values.firstWhere((e) => e.value == ln, orElse: () => ERole.none);

  bool get noRole => this == ERole.none;
  bool get isOwner => this == ERole.owner;
  bool get hasRole => !noRole;
}
