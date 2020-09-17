import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String nome, IconData icon) {
  if (widget is FeatureItem) {
    return widget.titulo == nome && widget.icon == icon;
  }
  return false;
}
bool textFieldByLabelTextMatcher(Widget widget, String labelText) {
  if (widget is TextField) {
    return widget.decoration.labelText == labelText;
  }
  return false;
}