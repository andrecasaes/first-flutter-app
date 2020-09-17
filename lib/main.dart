import 'package:bytebank/database/dao/contatos_dao.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

import 'http/webclient/transaction_webclient.dart';

void main() {
  runApp(BytebankApp(
    contatosDao: ContatosDao(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContatosDao contatosDao;
  final TransactionWebClient transactionWebClient;

  BytebankApp(
      {@required this.contatosDao, @required this.transactionWebClient});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      transactionWebClient: transactionWebClient,
      contatosDao: contatosDao,
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.orange[900],
            accentColor: Colors.orange[700],
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.orange[700],
              textTheme: ButtonTextTheme.primary,
            )),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.orange[900],
            accentColor: Colors.orange[700],
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.orange[700],
              textTheme: ButtonTextTheme.primary,
            )),
        // home: Dashboard(),
        home: Dashboard(contatosDao: contatosDao),
      ),
    );
  }
}
