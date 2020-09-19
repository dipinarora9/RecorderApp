import 'package:flutter/material.dart';
import 'package:flutter_app/record_service.dart';
import 'package:provider/provider.dart';

import 'record_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recorder App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (_) => RecordService(),
        child: Record(),
      ),
    );
  }
}
