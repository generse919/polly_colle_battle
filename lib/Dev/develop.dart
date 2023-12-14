import 'dart:developer' as dart_dev;

class Develop {
  static const isRelease = bool.fromEnvironment('dart.vm.product');

  static void log(Object? description, {bool logging = false}) {
    final userLog =
        "$description\n~~~${DateTime.now()}\n${StackTrace.current.toString().split("#")[2]}";
    dart_dev.log(
      description.toString(),
      name: 'devlog',
      // time: DateTime.now(), name: 'devlog', stackTrace: StackTrace.current
    );

    // if (!isRelease && !logging) {
    //   return;
    // }

    // // final dir = await getExternalStorageDirectory();
    // final file = await LEFile.mkfile("${await LEFile.localPath}/log.txt");
    // await file!
    //     .writeAsString('${await file.readAsString()}$userLog\n', flush: false);
    // return;
  }

  static void errLog(Object? description,
      {Object? error, bool logging = false}) {
    final userLog =
        "$description\n~~~${DateTime.now()}\n${StackTrace.current.toString().split("#")[2]}";
    dart_dev.log(userLog,
        name: 'devlog', stackTrace: StackTrace.current, error: error);
  }
}
