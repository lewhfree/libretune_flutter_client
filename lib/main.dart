import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

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
  WidgetsFlutterBinding.ensureInitialized();

  // final dir = await getApplicationSupportDirectory();

  // final path = '${dir.path}/myFile.m4a';

  final record = AudioRecorder();
  if (await record.hasPermission()) {
    // Start recording to file
    // await record.start(const RecordConfig(), path: path);
    final stream = await record.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 24000,
        numChannels: 1,
        autoGain: true,
      ),
    );
    stream.listen((audioChunk) {});

    await Future.delayed(const Duration(seconds: 3));
    await record.stop();
    print("finished recording");
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
