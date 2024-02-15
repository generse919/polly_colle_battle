import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:polly_colle_battle/data/unityObjects/game_manager.dart';

class BattlePage extends StatefulWidget {
  const BattlePage({Key? key}) : super(key: key);

  @override
  State<BattlePage> createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {
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
    return Scaffold(
      body: Card(
          child: Stack(children: [
        UnityWidget(
          onUnityCreated: _onUnityCreated,
          onUnityMessage: _onUnityMessage,
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
                    },
                    child: const Text("Unload"),
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
    );
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    UWGameManager(controller).openScene(SceneList.battleScene);
  }

  void _onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }
}
