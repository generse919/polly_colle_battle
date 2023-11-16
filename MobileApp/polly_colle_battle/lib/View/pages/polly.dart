import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:polly_colle_battle/data/unityObjects/game_manager.dart';

class PollyPage extends ConsumerStatefulWidget {
  const PollyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PollyPageState();
}

class _PollyPageState extends ConsumerState<PollyPage> {
  UnityWidgetController? _unityWidgetController;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    UWGameManager(controller).openScene(SceneList.polly);
  }

  void _onUnityMessage(message) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(children: [
        SizedBox(
          height: 100,
          child: UnityWidget(
            onUnityCreated: _onUnityCreated,
            onUnityMessage: _onUnityMessage,
            fullscreen: true,
          ),
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
            )),
        ListView(
          children: const [
            Card(
              child: Text("写真を撮る"),
            ),
          ],
        ),
      ])),
    );
  }
}
