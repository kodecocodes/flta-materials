import 'dart:io';

import 'package:flutter/foundation.dart';

bool isDesktop() {
  if (kIsWeb) {
    return false;
  }
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

bool isWeb() {
  return kIsWeb;
}

