import 'package:polly_colle_battle/Dev/develop.dart';
import 'package:polly_colle_battle/data/unity_object.dart';
import 'package:polly_colle_battle/helper/string_helper.dart';

enum SceneList {
  polly,
  battle,
  none,
}

class UWGameManager extends UnityObject {
  UWGameManager(super.controller);
  @override
  String name() => "GameManager";

  //
  //開くシーン
  void openScene(SceneList scene) {
    String sceneName = "${scene.name}scene".toUpperCamelCase();
    controller.postMessage(name(), "OpenScene", sceneName);
  }

  void openModel(String path) {
    Develop.log("openModel $path");
    controller.postMessage(name(), "OpenModel", path);
  }
}
