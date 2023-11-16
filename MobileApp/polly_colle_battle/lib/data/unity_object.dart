import 'package:flutter_unity_widget/flutter_unity_widget.dart';

abstract class UnityObject {
  final UnityWidgetController controller;
  //メソッド
  UnityObject(this.controller);
  String name();
}
