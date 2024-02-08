import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:polly_colle_battle/View/AppTheme.dart';
import 'package:polly_colle_battle/View/pages/battle.dart';
import 'package:polly_colle_battle/View/pages/image_preview.dart';
import 'package:polly_colle_battle/View/pages/polly.dart';
import 'package:polly_colle_battle/View/pages/start.dart';
import 'package:polly_colle_battle/View/pages/title.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic),
          showPerformanceOverlay: (F.appFlavor == Flavor.dev),
          debugShowCheckedModeBanner: false,
          title: F.title,
          initialRoute: "/start",
          routes: {
            '/start': (context) => const StartPage(),
            '/title': (context) => const TitlePage(),
            '/battle': (context) => const BattlePage(),
            '/polly': (context) => const PollyPage(),
            '/polly_create_menu': (context) => const OnPollyMakeMenu(),
            '/polly_image_preview': (context) =>
                const ImagePreview(imagePath: "assets/images/apple.jpeg")
          },
          builder: (context, widget) {
            Widget error = const Text('...rendering error...');
            if (widget is Scaffold || widget is Navigator) {
              error = Scaffold(body: Center(child: error));
            }
            ErrorWidget.builder = (errorDetails) => error;
            if (widget != null) return widget;
            throw ('widget is null');
          },
        );
      },
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
