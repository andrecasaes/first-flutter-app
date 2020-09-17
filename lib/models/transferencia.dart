import 'package:bytebank/models/contato.dart';

class Tranferencia {
  final String id;
  final double valor;
  final Contato contato;

  Tranferencia(
    this.id,
    this.valor,
    this.contato,
  ) : assert(valor > 0);

  Tranferencia.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        valor = json['value'],
        contato = Contato.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': valor,
        'contact': contato.toJson(),
      };

  @override
  String toString() {
    return 'Tranferencia{valor: $valor, numero: }';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tranferencia && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}
