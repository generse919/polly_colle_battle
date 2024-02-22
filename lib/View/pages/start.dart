import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polly_colle_battle/Dev/develop.dart';
import 'package:polly_colle_battle/data/signIn_preference.dart';
import 'package:polly_colle_battle/data/unityObjects/game_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

////Providers////
///

final sharedPreferenceProvider = FutureProvider<SharedPreferences>(
    (ref) async => await SharedPreferences.getInstance());

class SignInPrefNotifier extends StateNotifier<SignInPreference> {
  SignInPrefNotifier(this.ref) : super(SignInPreference("", "")) {
    init();
  }
  final Ref ref;

  void updateEmail(String email) async {
    final pref = await ref.read(sharedPreferenceProvider.future);
    pref.setString('Email', email);
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) async {
    final pref = await ref.read(sharedPreferenceProvider.future);
    pref.setString('Password', password);
    state = state.copyWith(password: password);
  }

  init() async {
    ref.read(sharedPreferenceProvider.future).then((pref) {
      final email = pref.getString('Email') ?? '';
      final password = pref.getString('Password') ?? '';
      state = SignInPreference(email, password);
    });
  }
}

final signInPrefProvider =
    StateNotifierProvider<SignInPrefNotifier, SignInPreference>((ref) {
  return SignInPrefNotifier(ref);
});

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends ConsumerState<StartPage> {
  UnityWidgetController? _unityWidgetController;
  bool isPushStartButton = false;
  bool unityInitComplete = false;
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    initData();
    initTts();
  }

  //このページに戻ってきたとき
  @override
  void didUpdateWidget(StartPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initData();
  }

  initData() {
    final pref = ref.read(signInPrefProvider);
    final email = pref.email;
    final password = pref.password;
    if (!mounted) return;
    Develop.log("mount: Email: $email,Password: $password");
  }

  initTts() {
    flutterTts = FlutterTts();
    //男性の声に設定
    flutterTts.setVoice({"name": "Hattori", "locale": "ja-JP"});
    flutterTts.setLanguage("ja-JP");
    flutterTts.setSpeechRate(0.5);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    UWGameManager(controller).openScene(SceneList.titleScene);
  }

  void _onUnityMessage(message) {
    Develop.log("Unity: $message");
    if (message == "InitComplete") {
      setState(() {
        unityInitComplete = true;
      });
    }
    if (message is String && message.contains("ChatGPT:")) {
      flutterTts.speak(message.substring("ChatGPT:".length));
    }
  }

  Future<void> validateAndSubmit() async {
    try {
      final preference = ref.read(signInPrefProvider);
      User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: preference.email, password: preference.password))
          .user;
      print('Singed in: ${user?.uid}');
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<bool> showActionDialog(
      {required BuildContext context, required Widget child}) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((bool? value) {
      //Startボタンが押された場合
      if (value == true) {
        return validateAndSubmit().then<bool>((_) {
          Navigator.pushNamed(context, "/title");
          return true;
        },
            onError: (e) => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text("EmailまたはPasswordが間違っています"),
                      actions: <Widget>[
                        TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context, false);
                            }),
                      ],
                    )));
      }
      return false;
    });
  }

  Future<bool> showSignInDialog(context) {
    return showActionDialog(
        context: context,
        child: AlertDialog(
            title: Text(
              'EmailとPasswordを入力してください',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    onChanged: (String text) {
                      ref.read(signInPrefProvider.notifier).updateEmail(text);
                    },
                    decoration: InputDecoration(
                      hintText: ref.read(signInPrefProvider).email,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  TextField(
                    onChanged: (String text) {
                      ref
                          .read(signInPrefProvider.notifier)
                          .updatePassword(text);
                    },
                    decoration: InputDecoration(
                      hintText: ref
                          .read(signInPrefProvider)
                          .password
                          .replaceAll(RegExp(r'.'), '•'),
                    ),
                    textAlign: TextAlign.start,
                    obscureText: true,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
              TextButton(
                  child: const Text('START'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // UnityWidget(初期化で使用するため、非表示にしている)
          Positioned(
            top: 0,
            left: 0,
            child: Visibility(
                visible: true,
                maintainState: true,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: UnityWidget(
                    onUnityCreated: _onUnityCreated,
                    onUnityMessage: _onUnityMessage,
                    runImmediately: true,
                    fullscreen: true,
                  ),
                )),
          ),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width / 2 - 125,
            child: Text(
              "PollyColleBattle",
              style: GoogleFonts.pottaOne(
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
              // style:

              // TextStyle(
              //   fontSize: 30,
              //   color: Theme.of(context).colorScheme.primary,
              // )
            ),
          ),

          Positioned(
            top: 540,
            left: MediaQuery.of(context).size.width / 2 - 75,
            child: Column(
              children: [
                //スタートボタン
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      isPushStartButton = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      isPushStartButton = false;
                    });
                    //ログイン用画面を表示
                    //Unityの処理を一時停止
                    // _unityWidgetController?.pause();
                    // showSignInDialog(context).then((value) => {
                    //       if (!value) {_unityWidgetController?.resume()}
                    //     });
                    showSignInDialog(context);
                  },
                  onTapCancel: () {
                    setState(() {
                      isPushStartButton = false;
                    });
                  },
                  child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColorDark,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: (isPushStartButton)
                                ? const Offset(0, 0)
                                : const Offset(4, 4),
                          ),
                          BoxShadow(
                            color: Theme.of(context).primaryColorLight,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: (isPushStartButton)
                                ? const Offset(0, 0)
                                : const Offset(-4, -4),
                          )
                        ],
                      ),
                      child: Center(
                          child: Text("はじめる",
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
