import 'dart:convert';

import 'package:bytebank/http/webclient.dart';

// import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<Tranferencia> save(Tranferencia transaction, String senha) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(url,
        headers: {
          'Content-type': 'application/json',
          'password': senha,
        },
        body: transactionJson);

    if (response.statusCode == 200) {
      return _toTransaction(response);
    }
    _throwHttpError(response.statusCode);
  }

  void _throwHttpError(int statusCode) =>
      throw Exception(_statusCodeResponses[statusCode]);

  static final Map<int, String> _statusCodeResponses = {
    400: 'Erro submetendo a transação',
    401: 'Autenticação falhou',
    409: 'Transação já existe!'
  };

  Future<List<Tranferencia>> findAll() async {
    final Response response = await client.get(url);
    List<Tranferencia> transactions = _toTransactions(response);
    return transactions;
  }

  // versão 1
  // List<Tranferencia> _toTransactions(Response response) {
  //     final List<dynamic> decodedJson = jsonDecode(response.body);
  //   final List<Tranferencia> transactions = List();
  //   for (Map<String, dynamic> transactionJson in decodedJson) {
  //     final Map<String, dynamic> contactJson = transactionJson['contact'];
  //     final Tranferencia transaction = Tranferencia(
  //       transactionJson['value'],
  //       Contato(
  //         0,
  //         contactJson['name'],
  //         contactJson['accountNumber'],
  //       ),
  //     );
  //     transactions.add(transaction);
  //   }
  //   return transactions;
  // }

  //v2
  // List<Tranferencia> _toTransactions(Response response) {
  //   final List<dynamic> decodedJson = jsonDecode(response.body);
  //   final List<Tranferencia> transactions = List();
  //   for (Map<String, dynamic> transactionJson in decodedJson) {
  //     transactions.add(Tranferencia.fromJson(transactionJson));
  //   }
  //   return transactions;
  // }

  //v3
  List<Tranferencia> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) {
      return Tranferencia.fromJson(json);
    }).toList();
  }

  Tranferencia _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    // final Map<String, dynamic> contactJson = json['contact'];
    // return Tranferencia(
    //   json['value'],
    //   Contato(
    //     0,
    //     contactJson['name'],
    //     contactJson['accountNumber'],
    //   ),
    // );
    return Tranferencia.fromJson(json);
  }

// Map<String, dynamic> _toMap(Tranferencia transaction) {
//   final Map<String, dynamic> transactionMap = {
//     'value': transaction.valor,
//     'contact': {
//       'name': transaction.contato.nomeCompleto,
//       'accountNumber': transaction.contato.nroConta
//     }
//   };
//   return transactionMap;
// }
}
