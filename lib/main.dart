import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'dart:typed_data';
import 'dart:async';

void main() async {
  await AudioRecorder().hasPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(title: 'Home page'));
  }
}

void startAnalyze() async {
  print("startanalyze");
  WidgetsFlutterBinding.ensureInitialized();

  final record = AudioRecorder();
  if (await record.hasPermission()) {
    List<Uint8List> buf = [];
    Timer? _timer;
    final stream = await record.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 8000,
        numChannels: 1,
        autoGain: true,
      ),
    );
    print("1");
    final stram = stream.listen((audioChunk) {
      buf.add(audioChunk);
    });

    _timer = Timer(const Duration(seconds: 10), () async {
      await record.stop();
      await stram.cancel();
      // do the concatination
      print("do concat");
    });
  }
  record.dispose();
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(''),
            FilledButton(
              onPressed: startAnalyze,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Listen"), Icon(Icons.audiotrack)],
              ),
            ),
            Text('time/time sample length'),
          ],
        ),
      ),
    );
  }
}
