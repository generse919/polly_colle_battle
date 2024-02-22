import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  bool isPushBattleButton = false;
  bool isPushPollyButton = false;
  bool isPushTitleButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          Positioned(
            top: 220,
            left: 70,
            child: Text(
              """ここは\nメニューです。""",
              style: GoogleFonts.pottaOne(
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Positioned(
            top: 440,
            left: 70,
            child: Column(
              children: [
                //バトルボタン
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      isPushBattleButton = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      isPushBattleButton = false;
                    });
                    //戦闘画面
                    Navigator.pushNamed(context, "/battle");
                  },
                  onTapCancel: () {
                    setState(() {
                      isPushBattleButton = false;
                    });
                  },
                  child: Container(
                      height: 70,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColorDark,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: (isPushBattleButton)
                                ? const Offset(0, 0)
                                : const Offset(4, 4),
                          ),
                          BoxShadow(
                            color: Theme.of(context).primaryColorLight,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: (isPushBattleButton)
                                ? const Offset(0, 0)
                                : const Offset(-4, -4),
                          )
                        ],
                      ),
                      child: Center(
                          child: FittedBox(
                              child: Text(
                        "Battle(たたかう)",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )))),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                //ポリーボタン
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      isPushPollyButton = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      isPushPollyButton = false;
                    });
                    //ポリー画面
                    Navigator.pushNamed(context, "/polly");
                  },
                  onTapCancel: () {
                    setState(() {
                      isPushPollyButton = false;
                    });
                  },
                  child: Container(
                      height: 70,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColorDark,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: (isPushPollyButton)
                                ? const Offset(0, 0)
                                : const Offset(4, 4),
                          ),
                          BoxShadow(
                            color: Theme.of(context).primaryColorLight,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: (isPushPollyButton)
                                ? const Offset(0, 0)
                                : const Offset(-4, -4),
                          )
                        ],
                      ),
                      child: Center(
                          child: Text("Pollies(ポリー)",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )))),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                //タイトルボタン
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      isPushTitleButton = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      isPushTitleButton = false;
                    });
                    //ポリー画面
                    Navigator.pushNamed(context, "/start");
                  },
                  onTapCancel: () {
                    setState(() {
                      isPushTitleButton = false;
                    });
                  },
                  child: Container(
                      height: 70,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColorDark,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: (isPushTitleButton)
                                ? const Offset(0, 0)
                                : const Offset(4, 4),
                          ),
                          BoxShadow(
                            color: Theme.of(context).primaryColorLight,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: (isPushTitleButton)
                                ? const Offset(0, 0)
                                : const Offset(-4, -4),
                          )
                        ],
                      ),
                      child: Center(
                          child: Text("Quit(タイトルへ)",
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
