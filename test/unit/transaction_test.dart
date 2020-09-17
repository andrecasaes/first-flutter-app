import 'package:bytebank/models/transferencia.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Deve retornar o valor quando uma transacao for criada', (){
    final transferencia = Tranferencia(null, 200, null);
    expect(transferencia.valor, 200);
  });
  test('Deve retornar erro quando transacao tiver valor negativo', (){
    expect(() => Tranferencia(null, -20, null), throwsAssertionError);
  });
}