import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:image_picker/image_picker.dart';
import "package:path/path.dart" as path;
import 'package:polly_colle_battle/Dev/develop.dart';
import 'package:polly_colle_battle/View/pages/image_preview.dart';
import 'package:polly_colle_battle/data/polly_data.dart';
import 'package:polly_colle_battle/data/unityObjects/game_manager.dart';
import 'package:polly_colle_battle/data/websocket.dart';
import 'package:polly_colle_battle/helper/file_helper.dart';

class Polly {
  final PollyData data;
  SimpleWebSocket? socket;

  Polly(this.data, {this.socket});

  void create() {}
}

///Pollyのリストを管理するプロバイダ

class PollyListNotifier extends StateNotifier<List<Polly>> {
  PollyListNotifier(List<Polly> state) : super(state);

  void add(Polly polly) {
    //ソケットがある場合はコールバックを登録
    if (polly.socket != null) {
      polly.socket!.onMessage = (msg) {
        print(msg);
      };
    }
    state.add(polly);
  }

  void remove(Polly polly) {
    state.remove(polly);
  }

  void update(Polly polly) {
    state[state.indexOf(polly)] = polly;
  }
}

final appleImagePathProvider =
    StateNotifierProvider<MoveDocPathNotifier, AsyncValue<String>>((ref) {
  // const srcPath = "assets/images/apple.jpeg";
  // final dstPath = await FileHelper.appDocumentsDir
  //     .then((value) => "${value!.path}/${path.basename(srcPath)}");
  // await FileHelper.moveFile(File(srcPath), dstPath);
  // return dstPath;
  return MoveDocPathNotifier(srcPath: "assets/images/apple.jpeg");
});

class MoveDocPathNotifier extends StateNotifier<AsyncValue<String>> {
  MoveDocPathNotifier({required String srcPath, Key? key})
      : super(const AsyncValue.loading()) {
    _init(srcPath);
  }

  _init(String srcPath) async {
    state = const AsyncValue.loading();
    Develop.log("loading");
    //ファイルが存在するか確認
    const srcPath = "assets/images/apple.jpeg";
    final dstPath = await FileHelper.appDocumentsDir
        .then((value) => "${value!.path}/${path.basename(srcPath)}");
    final bytes = await rootBundle.load(srcPath);
    await FileHelper.moveFile(bytes, dstPath);
    state = AsyncValue.data(dstPath);
  }
}

final appleFbxPathProvider =
    StateNotifierProvider<MoveDocPathNotifier, AsyncValue<String>>((ref) {
  // const srcPath = "assets/models/apple.fbx";
  // final dstPath = await FileHelper.appDocumentsDir
  //     .then((value) => "${value!.path}/${path.basename(srcPath)}");
  // await FileHelper.moveFile(File(srcPath), dstPath);
  // return dstPath;
  return MoveDocPathNotifier(srcPath: "assets/models/apple.fbx");
});

final pollyListProvider =
    StateNotifierProvider<PollyListNotifier, List<Polly>>((ref) {
  final imagePathState = ref.watch(appleImagePathProvider);
  final fbxPathState = ref.watch(appleFbxPathProvider);
  List<Polly> list = [];

  if (imagePathState is AsyncData && fbxPathState is AsyncData) {
    list = [
      ...list,
      Polly(
        PollyData(
            name: "apple",
            imagePath: imagePathState.value!,
            pollyPath: fbxPathState.value!,
            status: PollyStatus.available),
      )
    ];
  }

  return PollyListNotifier(list);
});

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

    _moveFile();
    _connect();
  }

  _connect() {
    // ref.read(unitySocketProvider.notifier).connect();
  }

  _moveFile() {}

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    UWGameManager(controller).openScene(SceneList.polly);
  }

  void _onUnityMessage(message) {}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final pollyList = ref.watch(pollyListProvider);

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
                ...
                //pollyListの要素数分、名前のTextウィジェットを生成
                pollyList
                    .map((e) => InkWell(
                          onTap: () {
                            UWGameManager(_unityWidgetController!)
                                .openScene(SceneList.polly);
                          },
                          child: SizedBox(
                            height: 90,
                            child: Card(
                                child: Row(
                              children: [
                                const SizedBox(
                                  width: 87,
                                  child: Icon(Icons.star_border_outlined),
                                ),
                                Text(e.data.name),
                                Image.file(File(e.data.imagePath))
                              ],
                            )),
                          ),
                        ))
                    .toList(),
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
          InkWell(
            onTap: () async {
              await ImagePicker()
                  .pickImage(source: ImageSource.gallery)
                  .then((image) {
                if (image == null) return;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ImagePreview(
                          imagePath: image.path,
                        )));
              });
            },
            child: const Card(
                child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: Icon(Icons.image),
              ),
              title: Text('画像を選ぶ'),
              trailing: Icon(Icons.arrow_forward_ios),
            )),
          )
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
                        cameraController!.takePicture().then(
                          (image) {
                            if (image.path.isEmpty) return;
                            // 表示用の画面に遷移
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImagePreview(imagePath: image.path),
                                fullscreenDialog: true,
                              ),
                            );
                          },
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
