import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    final pref = await ref.read(sharedPreferenceProvider.future);
    final email = pref.getString('Email') ?? '';
    if (!mounted) return;
    Develop.log("mount: $email");
    ref.read(signInPrefProvider.notifier).updateEmail(email);
  }

  bool validateAndSave() {
    // final form = key.currentState;
    // if (form.validate()) {
    //   form.save();
    //   return true;
    // }
    // return false;
    return true;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: ref.read(signInPrefProvider).email, password: "123456"))
            .user;
        print('Singed in: ${user?.uid}');
      } catch (e) {
        print('Error: $e');
      }
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
            onError: (e) => print(e));
      }
    });
  }

  showSignInDialog(context) {
    showActionDialog(
        context: context,
        child: AlertDialog(
            title: const Text(
              'Enter server address:',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            content: TextField(
              onChanged: (String text) {
                ref.read(signInPrefProvider.notifier).updateEmail(text);
              },
              decoration: InputDecoration(
                hintText: ref.watch(signInPrefProvider).email,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('START'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
              TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
            ]));
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () async {
                      showSignInDialog(context);

                      // await validateAndSubmit();
                      // FirebaseAuth.instance
                      //     .authStateChanges()
                      //     .listen((User? user) {
                      //   if (user == null) {
                      //     print('User is currently signed out!');
                      //   } else {
                      //     print('User is signed in!');
                      //   }
                      // });
                      // Navigator.pushNamed(context, "/title");
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
