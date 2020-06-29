// ignore: avoid_web_libraries_in_flutterc
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter/foundation.dart' show kIsWeb;

void initAudio(String path) {
  if (kIsWeb) {
    js.context.callMethod('initiateAudio', [path]);
  } else {}
}

void playAudio() {
  if (kIsWeb) {
    js.context.callMethod('playAudio');
  } else {}
}

void pauseAudio() {
  if (kIsWeb) {
    js.context.callMethod('pauseAudio');
  } else {}
}

void seekAudio(int pos) {
  if (kIsWeb) {
    js.context.callMethod('seekAudio', [pos]);
  } else {}
}

void setAudioVolume(double volume) {
  if (kIsWeb) {
    js.context.callMethod('volAudio', [volume / 100]);
  } else {}
}

void stopAudio() {
  if (kIsWeb) {
    js.context.callMethod('stopAudio');
  } else {}
}
