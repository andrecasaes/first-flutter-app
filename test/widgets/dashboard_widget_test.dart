import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main(){
  testWidgets('Deve aparecer o imagem principal quando o dashboard é exibido', (WidgetTester teste) async{
    await teste.pumpWidget(MaterialApp(home: Dashboard()));
    final imagemPrincipal = find.byType(Image);
    expect(imagemPrincipal, findsOneWidget);
  });
  testWidgets('Deve aparecer a primeira funcionalidade quando o dashboard é exibido', (teste) async {
    await teste.pumpWidget(MaterialApp(home: Dashboard()));
    expect(find.byType(FeatureItem), findsWidgets);
  });
  testWidgets('Deve aparecer a funcionalidade de transferencia quando o dashboard é exibido', (teste) async {
    await teste.pumpWidget(MaterialApp(home: Dashboard()));
    expect(find.widgetWithIcon(FeatureItem,Icons.monetization_on), findsOneWidget);
    expect(find.widgetWithText(FeatureItem,'Transferir'), findsOneWidget);
  });
  //Outra forma de encontrar um widget
  testWidgets('Deve aparecer a funcionalidade de lista de transferencias quando o dashboard é exibido', (teste) async {
    await teste.pumpWidget(MaterialApp(home: Dashboard()));
    final transferListItem = find.byWidgetPredicate((widget) {
      return featureItemMatcher(widget, 'Lista Transf.', Icons.list);
    });
  });
}