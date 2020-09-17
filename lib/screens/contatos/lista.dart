import 'package:bytebank/database/dao/contatos_dao.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/form.dart';
import 'package:bytebank/screens/transferencia/form.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContatosLista extends StatefulWidget {
  final ContatosDao contatosDao;

  ContatosLista({@required this.contatosDao});

  @override
  _ContatosListaState createState() => _ContatosListaState();
}

class _ContatosListaState extends State<ContatosLista> {

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: List(),
        future: dependencies.contatosDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text('Carregando')],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contato contato = contatos[index];
                  return ItemContato(
                    contato,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TransactionForm(contato),
                        ),
                      );
                    },
                  );
                },
                itemCount: contatos.length,
              );
              break;
          }
          return Text('Erro desconhecido');
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => ContatosForm(),
                  ),
                )
                .then((value) => setState(() {}));
          }),
    );
  }
}

class ItemContato extends StatelessWidget {
  final Contato contato;
  final Function onClick;

  ItemContato(
    this.contato, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onClick,
        title: Text(
          contato.nomeCompleto,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(contato.nroConta.toString()),
      ),
    );
  }
}
