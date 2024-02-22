import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import "package:path/path.dart" as path;
import 'package:polly_colle_battle/Dev/develop.dart';
import 'package:polly_colle_battle/View/pages/polly.dart';
import 'package:polly_colle_battle/common/dialog.dart';
import 'package:polly_colle_battle/data/polly_data.dart';
import 'package:polly_colle_battle/data/websocket.dart';
import 'package:polly_colle_battle/helper/file_helper.dart';

part 'image_preview.freezed.dart';

@freezed
// @JsonSerializable()
class ImageDetails with _$ImageDetails {
  factory ImageDetails({
    Function(String? result)? onResult,
    Function()? onLoading,
    Function(Object? error, StackTrace? stackTrace)? onError,
  }) = _ImageDetails;

  // factory imageDetails.fromJson(Map<String, dynamic> json) =>
  //     _$imageDetailsFromJson(json);
}

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final sendImagePath =
    StateProvider.autoDispose<String?>((ref) => null); //サーバに送信する画像のパス

class ImageNotifier extends StateNotifier<AsyncValue<String?>> {
  ImageNotifier(this.ref, this.imagePath, this.details)
      : super(const AsyncValue.data(null)) {
    _postImage();
  }

  final Ref ref;
  final String? imagePath;
  final ImageDetails? details;

  Future<void> _postImage() async {
    if (imagePath == null) return; //画像がない場合は何もしない
    // try {
    //   state = const AsyncValue.loading();
    //   details?.onLoading?.call();
    //   var client = ref.read(httpClientProvider);
    //   const url = "http://60.130.217.219:8086";
    //   final uri = Uri.parse(url);
    //   var request = http.MultipartRequest('POST', uri)
    //     ..fields['filename'] = path.basename(imagePath!)
    //     ..fields['client_id'] = ref.read(spClientID).toString()
    //     ..files.add(await http.MultipartFile.fromPath('file', imagePath!));
    //   var response = await client.send(request);
    //   if (response.statusCode == HttpStatus.ok) {
    //     state = const AsyncValue.data('Image uploaded successfully');
    //     final sock = ref.read(webSocketProvider);
    //     //コールバックの登録
    //     sock.onOpen = () {
    //       print('open');
    //       sock.send('hello world');
    //     };

    //     sock.onMessage = (dynamic msg) {
    //       print('message: $msg');
    //     };

    //     sock.onClose = (int? code, String? reason) {
    //       print('close: $reason');
    //     };
    //     ref.read(webSocketProvider.notifier).state = sock;
    //     ref.read(webSocketProvider.notifier).connect();
    //     details?.onResult?.call(state.asData?.value);
    //   } else {
    //     state = AsyncValue.error('Failed to upload image', StackTrace.current);
    //     details?.onError?.call(state.asError?.error, state.asError?.stackTrace);
    //   }
    // } catch (e) {
    //   state = AsyncValue.error(e.toString(), StackTrace.current);
    //   details?.onError?.call(state.asError?.error, state.asError?.stackTrace);
    // }
  }
}

final imageNotifierProvider = StateNotifierProvider.autoDispose
    .family<ImageNotifier, AsyncValue<String?>, ImageDetails?>((ref, details) {
  final path = ref.watch(sendImagePath);
  return ImageNotifier(ref, path, details);
});

/////こっから本格実装
///
///

final simpleWebSocketProvier =
    StateNotifierProvider.autoDispose<SimpleWebSocketNotifier, SimpleWebSocket>(
        (ref) {
  return SimpleWebSocketNotifier();
});

class ImagePreview extends ConsumerStatefulWidget {
  const ImagePreview({super.key, required this.imagePath});
  final String imagePath;

  @override
  ConsumerState<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends ConsumerState<ImagePreview> {
  ImageDetails? _details;

  String generateRandomString(int length) {
    const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => letters.codeUnitAt(random.nextInt(letters.length))));
  }

  ///取得した画像を送信する
  _sendFileToModelConvertServer() async {
    //送信する画像パスを更新
    // ref.read(sendImagePath.notifier).state = widget.imagePath;

    //ファイルをドキュメントディレクトリに保存
    final docDir = await FileHelper.appDocumentsDir;

    final imgPath =
        "${docDir!.path}/${generateRandomString(8)}${path.extension(widget.imagePath)}";
    final file = File(imgPath);
    final srcFile = File(widget.imagePath);

    final sendData = await srcFile.readAsBytes();

    await file.writeAsBytes(sendData);

    final newWebSocket = SimpleWebSocket("ws://www.sm-my-palace.com:8086");

    newWebSocket.onOpen = () {
      Develop.log('WebSocket connection opened.');
    };

    final addPolly = Polly(
        PollyData(
            name: path.basenameWithoutExtension(imgPath),
            imagePath: imgPath,
            status: PollyStatus.loading,
            data_cache: {}),
        socket: newWebSocket);

    ref.read(pollyListProvider.notifier).add(addPolly);

    newWebSocket.onClose = (code, reaso) {
      Develop.log('WebSocket connection closed. $reaso');
    };

    await newWebSocket.connect();

    int sequence = 0;

    ///Jsonデータを作成し、送信する。
    for (int i = 0; i < sendData.length;) {
      List<int> bytes;
      if (sendData.length - i < 1024) {
        bytes = sendData.sublist(i, sendData.length);
      } else {
        bytes = sendData.sublist(i, i + 1024);
      }
      i += bytes.length;

      SendPhotoData chunkData = SendPhotoData(
          sequence: sequence++,
          bytesBase64: base64Encode(bytes),
          filename: path.basename(imgPath),
          clientId: i,
          lastchunk: (i >= sendData.length));
      //Jsonデータを送信
      // Develop.log("send: ${chunkData.toJson()}");
      // await Future.delayed(const Duration(milliseconds: 100));
      newWebSocket.send(chunkData.toJson());
    }
  }

  @override
  void initState() {
    super.initState();
    _subscribeMethodCallBack(context);
  }

  _subscribeMethodCallBack(BuildContext context) {
    _details = ImageDetails(onResult: (result) async {
      Navigator.popUntil(context, ModalRoute.withName("/polly"));
    }, onLoading: () {
      showLoadingDialog(context: context);
      Navigator.popUntil(context, ModalRoute.withName("/polly"));
    }, onError: (error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      Navigator.popUntil(context, ModalRoute.withName("/polly"));
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageDetalis = ref.watch(imageNotifierProvider(_details));
    final webSocket = ref.watch(simpleWebSocketNotifyProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.file(File(widget.imagePath)),
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
                              onPressed: () {
                                _sendFileToModelConvertServer();
                                Navigator.popUntil(
                                    context, ModalRoute.withName("/polly"));
                              },
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
