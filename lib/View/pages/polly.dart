import 'dart:convert';
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
  PollyListNotifier(super.state);

  static Map<int, List<int>> fileData = {};
  static int total_bytes = 0;

  void remove(Polly polly) {
    state.remove(polly);
  }

  void update(Polly polly) {
    var newState = List<Polly>.empty(growable: true);
    for (var e in state) {
      if (polly.data.name != e.data.name) {
        newState.add(e);
      } else {
        newState.add(polly);
      }
    }
    state = newState;

    // state[state.indexOf(polly)] = polly;
  }

  Polly getPolly(Polly polly) {
    for (var e in state) {
      if (polly.data.name == e.data.name) {
        return e;
      }
    }
    return Polly(PollyData(
        name: "invalid",
        imagePath: "",
        pollyPath: "",
        status: PollyStatus.invalid));
  }

  pollyWrite(Polly polly, String filename) async {
    //キャッシュされていたバイトデータをシーケンス番号順にソートする。
    List<int> sortedList = [];

    var entries = polly.data.data_cache!.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    for (var entry in entries) {
      sortedList.addAll(entry.value);
    }

    for (int i = 0; i < entries.length; i++) {
      if (entries[i].key != i) {
        Develop.log("sequence error: ${entries[i].key}");
      }
    }

    Develop.log(filename);

    await FileHelper.writeNewBytes(sortedList, filename);
  }

  void add(Polly polly) {
    //ソケットがある場合はコールバックを登録
    if (polly.socket != null) {
      polly.socket!.onMessage = (data) {
        var message = jsonDecode(data);
        // Develop.log("message: ${message['status']}");
        //messageにstatusが含まれている場合は、statusを更新する。
        if (message.containsKey('status')) {
          PollyStatus status = PollyStatus.invalid;
          final oldPolly = getPolly(polly);
          switch (message['status']) {
            case "model_creation_started":
              break;

            ///モデル生成完了したら、ファイルパスを登録する。
            case "model_creation_finished":
              FileHelper.appDocumentsDir.then((value) {
                Develop.log("fileData: ${message["sequence"]}");
                final moveDir =
                    "${value!.path}/${path.basenameWithoutExtension(polly.data.imagePath)}.glb";
                final newPolly = Polly(
                    oldPolly.data.copyWith(
                        pollyPath: moveDir,
                        data_cache: fileData,
                        status: PollyStatus.available),
                    socket: null);
                //pollyを書き込む。
                pollyWrite(newPolly, moveDir);
                update(newPolly);
                Develop.log("total_bytes: $total_bytes");
                total_bytes = 0;
                oldPolly.socket?.close();
              });

              break;
            case "model_creation_failed":
              status = PollyStatus.delete;
              break;
            case "model_creation_send":
              var chunkData = base64Decode(message['filedata']);
              // Develop.log("chunkData: ${chunkData.length}");
              // Develop.log("sequence: ${message['sequence']}");
              // Develop.log("${fileData.length}");

              ///static変数にデータを追加
              fileData[message['sequence']] = chunkData;
              total_bytes += chunkData.length;
              // var newData = oldPolly.data.data_cache!;
              // newData.addAll({message['sequence']: chunkData});
              // update(Polly(
              //   oldPolly.data.copyWith(data_cache: newData),
              // ));
              break;
            default:
              status = PollyStatus.invalid;
              break;
          }
          // ref
          //     .read(pollyListProvider.notifier)
          //     .updateStatus(status, path.basenameWithoutExtension(imgPath));
        }
        // fileData.addAll(chunkData);
        // if (fileData.length >= message['filesize']) {
        //   writeToFile(fileData);
        //   fileData.clear();
        // }
        // print(msg);
      };
    }
    state.add(polly);
  }
}

final appleImagePathProvider = StateNotifierProvider.family<MoveDocPathNotifier,
    AsyncValue<String>, String>((ref, path) {
  // const srcPath = "assets/images/apple.jpeg";
  // final dstPath = await FileHelper.appDocumentsDir
  //     .then((value) => "${value!.path}/${path.basename(srcPath)}");
  // await FileHelper.moveFile(File(srcPath), dstPath);
  // return dstPath;
  return MoveDocPathNotifier(srcPath: path);
});

final selectedPollyStateProvider = StateProvider<Polly?>((ref) => null);

class MoveDocPathNotifier extends StateNotifier<AsyncValue<String>> {
  MoveDocPathNotifier({required String srcPath, Key? key})
      : super(const AsyncValue.loading()) {
    _init(srcPath);
  }

  _init(String srcPath) async {
    state = const AsyncValue.loading();
    Develop.log("loading");
    //ファイルが存在するか確認
    final dstPath = await FileHelper.appDocumentsDir
        .then((value) => "${value!.path}/${path.basename(srcPath)}");
    final srcBytes = await rootBundle.load(srcPath);
    await FileHelper.moveFileByteData(srcBytes, dstPath);
    final dstBytes = await File(dstPath).readAsBytes();
    Develop.log("move : ${dstBytes.length}");
    state = AsyncValue.data(dstPath);
  }
}

final assetMoveProvider = StateNotifierProvider.family<MoveDocPathNotifier,
    AsyncValue<String>, String>((ref, path) {
  return MoveDocPathNotifier(srcPath: path);
});

final pollyListProvider =
    StateNotifierProvider<PollyListNotifier, List<Polly>>((ref) {
  final appleJpegPathState =
      ref.watch(assetMoveProvider("assets/images/apple.jpeg"));
  final appleGlbPathState =
      ref.watch(assetMoveProvider("assets/models/apple.glb"));
  final bananaJpegPathState =
      ref.watch(assetMoveProvider("assets/images/banana.jpeg"));
  final bananaGlbPathState =
      ref.watch(assetMoveProvider("assets/models/banana.glb"));
  final icecreamJpegPathState =
      ref.watch(assetMoveProvider("assets/images/icecream.jpeg"));
  final icecreamGlbPathState =
      ref.watch(assetMoveProvider("assets/models/icecream.glb"));
  final wrestlerJpegPathState =
      ref.watch(assetMoveProvider("assets/images/wrestler.jpeg"));
  final wrestlerGlbPathState =
      ref.watch(assetMoveProvider("assets/models/wrestler.glb"));
  // final cakeJpegPathState =
  //     ref.watch(assetMoveProvider("assets/images/cake.jpg"));
  // final cakeGlbPathState =
  //     ref.watch(assetMoveProvider("assets/models/cake.glb"));

  List<Polly> list = [];

  if (appleJpegPathState is AsyncData &&
          appleGlbPathState is AsyncData &&
          bananaJpegPathState is AsyncData &&
          bananaGlbPathState is AsyncData &&
          icecreamJpegPathState is AsyncData &&
          icecreamGlbPathState is AsyncData &&
          wrestlerJpegPathState is AsyncData &&
          wrestlerGlbPathState is AsyncData
      // &&
      // cakeJpegPathState is AsyncData &&
      // cakeGlbPathState is AsyncData

      ) {
    list = [
      ...list,
      Polly(
        PollyData(
            name: "apple",
            imagePath: appleJpegPathState.value!,
            pollyPath: appleGlbPathState.value!,
            status: PollyStatus.available),
      ),
      Polly(
        PollyData(
            name: "banana",
            imagePath: bananaJpegPathState.value!,
            pollyPath: bananaGlbPathState.value!,
            status: PollyStatus.available),
      ),
      Polly(
        PollyData(
            name: "icecream",
            imagePath: icecreamJpegPathState.value!,
            pollyPath: icecreamGlbPathState.value!,
            status: PollyStatus.available),
      ),
      Polly(
        PollyData(
            name: "wrestler",
            imagePath: wrestlerJpegPathState.value!,
            pollyPath: wrestlerGlbPathState.value!,
            status: PollyStatus.available),
      ),
      // Polly(
      //   PollyData(
      //       name: "cake",
      //       imagePath: cakeJpegPathState.value!,
      //       pollyPath: cakeGlbPathState.value!,
      //       status: PollyStatus.available),
      // ),
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
    UWGameManager(controller).openScene(SceneList.pollyScene);
  }

  void _onUnityMessage(message) {
    Develop.log("Unity: $message");
  }

  ///星マークをタップした時
  _confirmChangeSelectedPolly(Polly p) async {
    final isSelect = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('操作モデル選択'),
        content: Text('操作モデルを${p.data.name}にしますか？'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context, true);
              });
            },
            child: const Text('はい'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context, false);
              });
            },
            child: const Text('いいえ'),
          )
        ],
      ),
    );
    if (isSelect!) {
      ref.read(selectedPollyStateProvider.notifier).state = p;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final pollyList = ref.watch(pollyListProvider);
    ref.listen(pollyListProvider, (previous, next) {
      if (!mounted) return;
      if (previous != null && previous.length < next.length) {
        ref.read(selectedPollyStateProvider.notifier).state = next.first;
      }
    });

    final selectedPolly = ref.watch(selectedPollyStateProvider);

    return PopScope(
        canPop: false,
        child: Scaffold(
          body: Stack(children: [
            Column(
              children: [
                SizedBox(
                    height: height / 2,
                    child: UnityWidget(
                      onUnityCreated: _onUnityCreated,
                      onUnityMessage: _onUnityMessage,
                      fullscreen: true,
                    )),
                Expanded(
                  child:
                      // GestureDetector(
                      //   onTapDown: (details) {
                      //     _unityWidgetController?.pause();
                      //   },
                      //   onTapUp: (details) {
                      //     _unityWidgetController?.resume();
                      //   },
                      //   onTapCancel: () {
                      //     _unityWidgetController?.resume();
                      //   },
                      //   child:
                      // ),

                      ListView(
                    cacheExtent: 10,
                    children: [
                      //写真を撮るカード
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
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
                      pollyList.map((e) => InkWell(
                            onTap: () {
                              UWGameManager(_unityWidgetController!).openModel(
                                  OpenModelParam(
                                      path: e.data.pollyPath!,
                                      objName: "MainModel"));
                            },
                            child: SizedBox(
                              height: 90,
                              child: Card(
                                  child: Row(
                                children: [
                                  InkWell(
                                    onTap: () => _confirmChangeSelectedPolly(e),
                                    child: SizedBox(
                                      width: 87,
                                      child: (selectedPolly != null &&
                                              selectedPolly.hashCode ==
                                                  e.hashCode)
                                          ? const Icon(Icons.star)
                                          : const Icon(
                                              Icons.star_border_outlined),
                                    ),
                                  ),
                                  Expanded(child: Text(e.data.name)),
                                  Image.file(File(e.data.imagePath))
                                ],
                              )),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                top: 30,
                left: 10,
                child: Card(
                  elevation: 20,
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          _unityWidgetController?.unload();
                          Navigator.pop(context);
                        },
                        child: const Text("＜"),
                      ),
                    ],
                  ),
                )),
          ]),
        ));
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
      body: Column(
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
      ),
    );
  }
}

final fprbCameraInit = FutureProvider.family
    .autoDispose<CameraController, CameraDescription>((ref, camera) async {
  final cameraController = CameraController(camera, ResolutionPreset.max);
  await cameraController.initialize();
  return cameraController;
});

final fprbCameraAvailableList =
    FutureProvider.autoDispose<List<CameraDescription>>(
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
    Develop.log("dispose");
    super.dispose();
  }

  _onTapTakePictureButton() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }

    cameraController!.takePicture().then((image) {
      if (image.path.isEmpty) return;
      // 表示用の画面に遷移
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImagePreview(imagePath: image.path),
          fullscreenDialog: true,
        ),
      );
    });
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
                      onTap: _onTapTakePictureButton,
                      child: const Icon(Icons.add_a_photo),
                    ),
                    onPressed: () {},
                  ));
            });
      },
    );
  }
}
