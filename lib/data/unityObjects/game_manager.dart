import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:polly_colle_battle/Dev/develop.dart';
import 'package:polly_colle_battle/data/unity_object.dart';
import 'package:polly_colle_battle/helper/string_helper.dart';

part 'game_manager.freezed.dart';
part 'game_manager.g.dart';

///
///UnityのGameManagerクラス
///
///※記法ルール
///・ここに定義するメソッドはUnity側で実装する必要がある。
///・呼び出しの際は、ログ出力をする。
///・メソッドに引数を渡す際は、json化したクラスパラメータを文字列に変換し、渡す。
///
///双方間のデータ受け渡しについては、以下のファイルを参照。
///https://drive.google.com/file/d/1t9tGEz6abt_pLEkkMxd4gDzld_n0nRCz/view?usp=drive_link
///
///

enum SceneList {
  pollyScene,
  battleScene,
  pollySceneDemo,
  none,
}

@freezed
class SceneParam with _$SceneParam {
  factory SceneParam(SceneList sceneName) = _SceneParam;

  factory SceneParam.fromJson(Map<String, dynamic> json) =>
      _$SceneParamFromJson(json);
}

@freezed
class OpenModelParam with _$OpenModelParam {
  factory OpenModelParam({
    required String path, //デバイス内のファイルパス
    required final String objName, //シーン内のGameObject名を入れる。
  }) = _OpenModelParam;

  factory OpenModelParam.fromJson(Map<String, dynamic> json) =>
      _$OpenModelParamFromJson(json);
}

class UWGameManager extends UnityObject {
  UWGameManager(super.controller);
  @override
  String name() => "GameManager";

  //
  //開くシーン
  void openScene(SceneList scene) {
    String sceneName = scene.name.toUpperCamelCase();
    controller.postMessage(name(), "OpenScene", sceneName);
  }

  void openModel(OpenModelParam param) {
    Develop.log("openModel ${param.toJson().toString().convertToJson()}");
    controller.postMessage(
        name(), "OpenModel", param.toJson().toString().convertToJson());
  }

  void setDarkMode(bool isDarkMode) {
    controller.postMessage(name(), "SetDarkMode", isDarkMode);
  }
}
