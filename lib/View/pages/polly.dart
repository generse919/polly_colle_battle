import 'dart:io';

import 'package:camera/camera.dart';
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
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          child: Column(
        children: [
          SizedBox(
              height: height / 2,
              child: UnityWidget(
                onUnityCreated: _onUnityCreated,
                onUnityMessage: _onUnityMessage,
                fullscreen: true,
              )),
          Expanded(
            child: ListView(
              children: [
                //写真を撮るカード
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const OnPollyMakeMenu())),
                  child: SizedBox(
                    height: 90,
                    child: Card(
                        color: Theme.of(context).colorScheme.secondary,
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 87,
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                            Text("ポリを作る"),
                          ],
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: 90,
                    child: Card(
                        child: Row(
                      children: [
                        SizedBox(
                          width: 87,
                          child: Icon(Icons.star_border_outlined),
                        ),
                        Text("モデル1(表示)"),
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class OnPollyMakeMenu extends StatefulWidget {
  const OnPollyMakeMenu({super.key});

  @override
  State<OnPollyMakeMenu> createState() => _OnPollyMakeMenuState();
}

class _OnPollyMakeMenuState extends State<OnPollyMakeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("作成方法"),
      ),
      body: Container(
          child: Column(
        children: [
          InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const TakeAPhotoPage())),
              child: const Card(
                  child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.camera_alt),
                ),
                title: Text('写真を撮る'),
                trailing: Icon(Icons.arrow_forward_ios),
              ))),
          const Card(
              child: ListTile(
            leading: SizedBox(
              width: 50,
              height: 50,
              child: Icon(Icons.image),
            ),
            title: Text('画像を選ぶ'),
            trailing: Icon(Icons.arrow_forward_ios),
          )),
        ],
      )),
    );
  }
}

final fprbCameraInit =
    FutureProvider.family<CameraController, CameraDescription>(
        (ref, camera) async {
  final cameraController = CameraController(camera, ResolutionPreset.max);
  await cameraController.initialize();
  return cameraController;
});

final fprbCameraAvailableList = FutureProvider<List<CameraDescription>>(
    (ref) async => await availableCameras());

//写真を撮るシーン
class TakeAPhotoPage extends ConsumerStatefulWidget {
  const TakeAPhotoPage({super.key});

  @override
  ConsumerState<TakeAPhotoPage> createState() => _TakeAPhotoPageState();
}

class _TakeAPhotoPageState extends ConsumerState<TakeAPhotoPage> {
  List<CameraDescription>? cameras;
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<CameraDescription>> avListDesc =
        ref.watch(fprbCameraAvailableList);
    //カメラのリストを取得
    return avListDesc.when(
      error: (error, st) => Container(),
      loading: () => const CircularProgressIndicator(),
      data: (data) {
        setState(() {
          cameras = data;
        });
        final AsyncValue<CameraController> avCameraCont =
            ref.watch(fprbCameraInit(cameras!.first));
        return avCameraCont.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Container(),
            data: (controller) {
              setState(() {
                cameraController = controller;
              });
              return Scaffold(
                  body: CameraPreview(cameraController!),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: FloatingActionButton(
                    child: GestureDetector(
                      // タップした時
                      onTap: () async {
                        // 写真撮影
                        final image = await cameraController!.takePicture();

                        // 表示用の画面に遷移
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ImagePreview(imagePath: image.path),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: const Icon(Icons.add_a_photo),
                    ),
                    onPressed: () {},
                  ));
            });
      },
    );
  }
}

class ImagePreview extends StatefulWidget {
  const ImagePreview({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Stack(
        children: [
          Image.file(
            File(widget.imagePath),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      const Text("この写真を使用しますか？"),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilledButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("はい")),
                          FilledButton.tonal(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("いいえ")),
                        ],
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
