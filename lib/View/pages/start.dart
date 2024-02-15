import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:polly_colle_battle/Dev/develop.dart';
import 'package:polly_colle_battle/data/signIn_preference.dart';
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

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    final pref = ref.read(signInPrefProvider);
    final email = pref.email;
    final password = pref.password;
    if (!mounted) return;
    Develop.log("mount: Email: $email,Password: $password");
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
  }

  void _onUnityMessage(message) {
    Develop.log("Unity: $message");
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

  void showActionDialog<T>(
      {required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
      // if (value != null) {
      //   if (value == DialogDemoAction.connect) {
      //     _prefs.setString('server', _server);
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (BuildContext context) => _datachannel
      //                 ? DataChannelSample(host: _server)
      //                 : CallSample(host: _server)));
      //   }
      // }
      if (value == true) {
        validateAndSubmit().then((_) => Navigator.pushNamed(context, "/title"),
            onError: (e) => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text(e.toString()),
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
                      ],
                    )));
      }
    });
  }

  showSignInDialog(context) {
    showActionDialog<bool>(
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
          //UnityWidget(初期化で使用するため、非表示にしている)
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   child: Visibility(
          //       visible: true,
          //       maintainState: true,
          //       child: SizedBox(
          //         width: MediaQuery.of(context).size.width,
          //         height: MediaQuery.of(context).size.height,
          //         child: UnityWidget(
          //           onUnityCreated: _onUnityCreated,
          //           onUnityMessage: _onUnityMessage,
          //           runImmediately: true,
          //           fullscreen: true,
          //         ),
          //       )),
          // ),
          Positioned(
            top: 220,
            left: 110,
            right: 110,
            child: Text("PollyColle-ばとる",
                style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'PottaOne')),
          ),
          Positioned(
            top: 440,
            left: 70,
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      //ログイン用画面を表示
                      showSignInDialog(context);
                    },
                    child: const Text("Start")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
