enum Res {
  success(200),
  noContent(201),
  badRequest(400),
  forbidden(403),
  unauthorized(401),
  notFound(404),
  internalServer(500),
  defaultCode(-1),
  noInternet(-7);

  const Res(this.value);
  final int value;
}

Res getResponseCode(int? ln) =>
    Res.values.firstWhere((e) => e.value == ln, orElse: () => Res.defaultCode);
