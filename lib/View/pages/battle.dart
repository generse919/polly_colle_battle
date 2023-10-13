import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

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
            child: PointerInterceptor(
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
            )))
      ])),
    );
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  void _onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }
}
