import 'package:flutter/material.dart';

/// ローディングダイアログを表示する
///
/// [context] ダイアログを表示するコンテキスト
Future<void> showLoadingDialog({
  required BuildContext context,
}) async {
  showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 250),
      barrierColor: Colors.black.withOpacity(0.5), // 画面マスクの透明度
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Text(
                  "読み込み中",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        );
      });
}
