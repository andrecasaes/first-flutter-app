import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/dao/contatos_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContatosForm extends StatefulWidget {
  final ContatosDao contatosDao;

  ContatosForm({@required this.contatosDao});

  @override
  _ContatosFormState createState() => _ContatosFormState();
}

class _ContatosFormState extends State<ContatosForm> {

  final TextEditingController _controladorNomeCompleto =
      new TextEditingController();

  final TextEditingController _controladorNroConta =
      new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Contato'),
      ),
      body: Column(
        children: [
          Editor(
            rotulo: 'Nome Completo',
            controlador: _controladorNomeCompleto,
          ),
          Editor(
            rotulo: 'Numero Conta',
            dica: '0000',
            tipoTeclado: TextInputType.number,
            controlador: _controladorNroConta,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                onPressed: () {
                  final Contato novoContato = Contato(
                    0,
                    _controladorNomeCompleto.text,
                    int.tryParse(_controladorNroConta.text
                    ),
                  );
                  _save(dependencies.contatosDao ,novoContato, context);
                },
                child: Text('Salvar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _save(ContatosDao contatosDao, Contato newContact, BuildContext context) async {
    await contatosDao.save(newContact);
    Navigator.pop(context);
  }
}
