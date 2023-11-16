import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelPage extends ConsumerStatefulWidget {
  const ModelPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ModelPageState();
}

class _ModelPageState extends ConsumerState<ModelPage> {
  String tex = "None";
  late InternetAddress serverAddress;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        TextButton(
          child: const Text("connect"),
          onPressed: () {
            // setState(() async {
            //   var port = 8890;
            //   tex = "Loading";
            //   var sender =
            //       await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);

            //   final ntpQuery = Uint8List(48);
            //   ntpQuery[0] = 0x23; // See RFC 5905 7.3

            //   sender.listen((event) {
            //     switch (event) {
            //       case RawSocketEvent.read:
            //         final datagram = sender.receive();
            //         // Parse `datagram.data`
            //         sender.close();
            //         break;
            //       case RawSocketEvent.write:
            //         if (sender.send(ntpQuery, serverAddress, port) > 0) {
            //           sender.writeEventsEnabled = false;
            //         }
            //         break;
            //       case RawSocketEvent.closed:
            //         break;
            //       default:
            //         throw "Unexpected event $event";
            //     }
            //   });

            //   ref.read(spSocket.notifier).state = sender;
            // });
          },
        ),
        Text(tex),
      ],
    ));
  }
}
