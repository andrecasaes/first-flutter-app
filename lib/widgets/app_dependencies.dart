import 'package:bytebank/database/dao/contatos_dao.dart';
import 'package:bytebank/http/webclient/transaction_webclient.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {
  final ContatosDao contatosDao;
  final TransactionWebClient transactionWebClient;

  AppDependencies({
    @required this.transactionWebClient,
    @required this.contatosDao,
    @required Widget child,
  }) : super(child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contatosDao != oldWidget.contatosDao ||
        transactionWebClient != oldWidget.transactionWebClient;
  }
}