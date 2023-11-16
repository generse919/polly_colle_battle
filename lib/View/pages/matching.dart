// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';

// class MatchingPage extends ConsumerStatefulWidget {
//   const MatchingPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _MatchingPageState();
// }

// class _MatchingPageState extends ConsumerState<MatchingPage> {
//   RtcPeerConnection? _peerConnection;
//   MediaStream? _localStream;

//   _getUserMedia() async {
//     final Map<String, dynamic> mediaConstraints = {
//       'audio': true,
//       'video': {
//         'facingMode': 'user',
//       }
//     };

//     MediaStream stream =
//         await navigator.mediaDevices.getUserMedia(mediaConstraints);

//     // _localVideoRenderer.srcObject = stream;
//     return stream;
//   }

//   _createPeerConnecion() async {
//     Map<String, dynamic> configuration = {
//       "iceServers": [
//         {"url": "stun:stun.l.google.com:19302"},
//       ]
//     };

//     final Map<String, dynamic> offerSdpConstraints = {
//       "mandatory": {
//         "OfferToReceiveAudio": true,
//         "OfferToReceiveVideo": true,
//       },
//       "optional": [],
//     };

//     _localStream = await _getUserMedia();

//     RTCPeerConnection pc =
//         await createPeerConnection(configuration, offerSdpConstraints);

//     pc.addStream(_localStream!);

//     pc.onIceCandidate = (e) {
//       if (e.candidate != null) {
//         print(json.encode({
//           'candidate': e.candidate.toString(),
//           'sdpMid': e.sdpMid.toString(),
//           'sdpMlineIndex': e.sdpMLineIndex,
//         }));
//       }
//     };

//     pc.onIceConnectionState = (e) {
//       print(e);
//     };

//     pc.onAddStream = (stream) {
//       print('addStream: ' + stream.id);
//       _remoteVideoRenderer.srcObject = stream;
//     };

//     return pc;
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     _createPeerConnecion().then((pc) {
//       _peerConnection = pc;
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         TextButton(
//             onPressed: () {
//               //サーバーとの接続
//             },
//             child: const Text("対戦")),
//       ],
//     ));
//   }
// }
