import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitlePage extends ConsumerWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 220,
            left: 110,
            right: 110,
            child: Text(
              "PollyColle-ばとる",
            ),
          ),
          Positioned(
            top: 440,
            left: 70,
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/battle");
                    },
                    child: const Text("Battle")),
                const TextButton(onPressed: null, child: Text("Pollies")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
