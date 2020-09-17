import 'package:sqflite/sqflite.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/database/app_database.dart';

class ContatosDao{

  static const sqlCriaContato = 'CREATE TABLE $_nomeTabela('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'account_number INTEGER)';

  static const String _nomeTabela = 'contatos';
  static const String _id = 'id';
  static const String _nome = 'name';
  static const String _nroConta = 'account_number';

  Future<int> save(Contato contato) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contato);
    return db.insert(_nomeTabela, contactMap);
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_nome] = contato.nomeCompleto;
    contactMap[_nroConta] = contato.nroConta;
    return contactMap;
  }

  Future<List<Contato>> findAll() async{
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_nomeTabela);
    List<Contato> contacts = _toList(result);
    return contacts;
  }

  List<Contato> _toList(List<Map<String, dynamic>> result) {
    final List<Contato> contacts = List();
    for (Map<String, dynamic> row in result) {
      final Contato contact = Contato(
        row[_id],
        row[_nome],
        row[_nroConta],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}