import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timer/timerinfo.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
          create: (contex) => TimerInfo(), child: Home()),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer _timer;

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        var timerInfo = Provider.of<TimerInfo>(context, listen: false);
        timerInfo.updateTimeLeft();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<TimerInfo>(
              builder: (context, data, child) {
                return Text(data.getTimeLeft()?.toString() ?? "",
                    style: Theme.of(context).textTheme.headline1);
              },
            ),
            FlatButton(
              color: Colors.red,
              child: Text("Stop"),
              onPressed: () {
                _timer.cancel();
              },
            ),
            FlatButton(
              color: Colors.green,
              child: Text("Start"),
              onPressed: () {
                startTimer();
              },
            ),
            FlatButton(
              color: Colors.purple,
              child: Text("Clear"),
              onPressed: () {
                var timerInfo = Provider.of<TimerInfo>(context, listen: false);

                timerInfo.setTimeLeft(time: 60);
                startTimer();
              },
            ),
          ],
        ),
      ),
    );
  }
}


