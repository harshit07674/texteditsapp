import 'package:flutter/material.dart';

class UndoTextWidgetModel{
  String? undoFontFamily;
  String? undoData;
  double? undoXPos;
  double? undoYPos;
  double? undoRotate;
  double? undoSize;
  Color? undoColor;
  FontWeight? undoWeight;
  FontStyle? undoStyle;

  UndoTextWidgetModel({Key?key,this.undoData,this.undoColor,this.undoFontFamily,this.undoRotate,this.undoSize,this.undoStyle,this.undoWeight,this.undoXPos,this.undoYPos});

}
