import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordService with ChangeNotifier {
  String _currentFile;
  bool _recording = false;
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  String get currentFile => _currentFile;

  bool get recording => _recording;

  startRecording() async {
    Directory dir = await getApplicationDocumentsDirectory();
    _currentFile = DateTime.now().toIso8601String();
    try {
      PermissionStatus status = await Permission.microphone.request();
      if (status.isGranted) {
        await AudioRecorder.start(
          path: '${dir.path}/$_currentFile.m4a',
        );
        _recording = true;
        notifyListeners();
      } else {
        key.currentState.showSnackBar(
          SnackBar(
            content: Text('Permission not granted'),
          ),
        );
        _recording = false;
        notifyListeners();
      }
    } on Exception catch (_) {
      key.currentState.showSnackBar(
        SnackBar(
          content: Text('Permission not granted'),
        ),
      );
      _recording = false;
      notifyListeners();
    }
  }

  stopRecording() async {
    if (await AudioRecorder.isRecording) {
      await AudioRecorder.stop();
      _recording = false;
      notifyListeners();
    }
  }

  play() async {
    Directory dir = await getApplicationDocumentsDirectory();
    assetsAudioPlayer.open(
      Audio.file('${dir.path}/$_currentFile.m4a'),
    );
  }

  stopPlaying() async {
    await assetsAudioPlayer.stop();
  }
}
