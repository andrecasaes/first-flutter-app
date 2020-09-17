import 'package:bytebank/database/dao/contatos_dao.dart';
import 'package:bytebank/http/webclient/transaction_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContatosDao {}
class MockTransactionWebClient extends Mock implements TransactionWebClient {}