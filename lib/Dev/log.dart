import 'dart:developer' as dart_dev;

class Develop {
  static void log(Object? object) {
    String stackTrace = StackTrace.current.toString();
    String topStack = stackTrace.split("#1")[1].split("#2")[0];
    dart_dev.log(
        "${object.toString()} : [${topStack.substring(0, topStack.indexOf(")")).trim()}]");
  }
}
