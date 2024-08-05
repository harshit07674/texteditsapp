import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textediting/helpers/widgets/movables.dart';


class TextWidgetProvider extends ChangeNotifier {
  List<Widget> widgetTexts = [];

  void add(MoveableStackItem item) {
   widgetTexts.add(item);
   notifyListeners();
  }
}
