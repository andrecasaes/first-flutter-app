class Contato {
  final int id;
  final String nomeCompleto;
  final int nroConta;

  Contato(
    this.id,
    this.nomeCompleto,
    this.nroConta,
  );

  @override
  String toString() {
    return 'Contato{id: $id, nomeCompleto: $nomeCompleto, nroConta: $nroConta}';
  }

  Contato.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nomeCompleto = json['name'],
        nroConta = json['accountNumber'];

  Map<String, dynamic> toJson() =>
      {
        'name': nomeCompleto,
        'accountNumber': nroConta,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contato &&
          runtimeType == other.runtimeType &&
          nomeCompleto == other.nomeCompleto &&
          nroConta == other.nroConta;

  @override
  int get hashCode => nomeCompleto.hashCode ^ nroConta.hashCode;
}
