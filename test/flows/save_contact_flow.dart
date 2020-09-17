import 'package:bytebank/main.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/form.dart';
import 'package:bytebank/screens/contatos/lista.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../widgets/dashboard_widget_test.dart';
import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    await tester.pumpWidget(BytebankApp(
      contatosDao: mockContactDao,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transferir', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContatosLista);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContatosForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate(
            (widget) => textFieldByLabelTextMatcher(widget, 'Nome Completo'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'André');

    final accountNumberTextField = find.byWidgetPredicate(
            (widget) => textFieldByLabelTextMatcher(widget, 'Numero Conta'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '1333');

    final createButton = find.widgetWithText(RaisedButton, 'Salvar');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDao.save(Contato(0,'André',1333)));

    final contactsListBack = find.byType(ContatosLista);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDao.findAll());
  });
}
