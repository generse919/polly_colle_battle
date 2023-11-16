import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final spSocket = StateProvider<RawDatagramSocket?>((ref) {
  return null;
});
