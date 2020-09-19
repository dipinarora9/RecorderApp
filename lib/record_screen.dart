import 'package:flutter/material.dart';
import 'package:flutter_app/record_service.dart';
import 'package:provider/provider.dart';

class Record extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recording = context.select((RecordService v) => v.recording);
    final recordService = Provider.of<RecordService>(context, listen: false);
    return Scaffold(
      key: recordService.key,
      appBar: AppBar(
        title: Text('Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!recording)
              RaisedButton(
                child: Text('Start Record'),
                onPressed: recordService.startRecording,
                color: Colors.blue.withOpacity(0.4),
              ),
            if (recording)
              RaisedButton(
                child: Text('Stop Record'),
                onPressed: recordService.stopRecording,
                color: Colors.blue.withOpacity(0.4),
              ),
            StreamBuilder<bool>(
              stream: recordService.assetsAudioPlayer.isPlaying,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data)
                  return RaisedButton(
                    child: Text('Stop Playing'),
                    onPressed: recordService.stopPlaying,
                    color: Colors.blue.withOpacity(0.4),
                  );
                else if (snapshot.hasData && !snapshot.data)
                  return RaisedButton(
                    child: Text('Play Playing'),
                    onPressed: recordService.play,
                    color: Colors.blue.withOpacity(0.4),
                  );
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
