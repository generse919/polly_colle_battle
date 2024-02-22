import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:polly_colle_battle/View/pages/polly.dart';
import 'package:polly_colle_battle/data/unityObjects/game_manager.dart';

///
///Unityのバトル画面
///
class BattlePage extends ConsumerStatefulWidget {
  const BattlePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BattlePageState();
}

class _BattlePageState extends ConsumerState<BattlePage> {
  UnityWidgetController? _unityWidgetController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _unityWidgetController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///このページはスワイプで画面を遷移してしまうと、アクセス違反が
    ///起こる事があるため、PopScopeで囲い、Unloadボタンで戻るようにする。
    ///
    final selectPolly = ref.watch(selectedPollyStateProvider);
    return PopScope(
        canPop: false,
        child: Scaffold(
          body: Card(
              child: Stack(children: [
            UnityWidget(
              onUnityCreated: _onUnityCreated,
              onUnityMessage: _onUnityMessage,
              onUnitySceneLoaded: (SceneLoaded? scene) {
                if (scene != null) {
                  //プレイヤー1のモデルURLを開かせる。
                  UWPlayer(_unityWidgetController!)
                      .setGLB(selectPolly!.data.pollyPath!);
                } else {
                  print('Received scene loaded from unity: null');
                }
              },
              fullscreen: true,
            ),
            Positioned(
                top: 20,
                left: 20,
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          _unityWidgetController?.unload();
                          Navigator.pop(context);
                        },
                        child: const Text("＜"),
                      ),
                      // MaterialButton(
                      //   onPressed: ()  {
                      //     _unityWidgetController?.create();
                      //   },
                      //   child: const Text("Unload"),
                      // ),
                    ],
                  ),
                ))
          ])),
        ));
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    UWGameManager(controller).openScene(SceneList.battleScene);
  }

  void _onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  // void _onUnitySceneLoaded(SceneLoaded? scene) {
  //   if (scene != null) {
  //     //プレイヤー1のモデルURLを開かせる。
  //     UWPlayer(controller).setGLB(glbURL);
  //   } else {
  //     print('Received scene loaded from unity: null');
  //   }
  // }
}
