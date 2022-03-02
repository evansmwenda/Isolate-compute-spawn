import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 50),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  ElevatedButton(
                    child: Text("Without Isolate"),
                    onPressed: () async {
                      final sum = computationallyExpensiveTask(1000000000);
                      print(sum);
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.green,
              height: 40,
              child: SizedBox(
                width: double.infinity,
                child: Text("Evans"),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  ElevatedButton(
                    child: Text("With Isolate- Compute"),
                    onPressed: () async {
                      final sum = await compute(
                          computationallyExpensiveTask, 1000000000);
                      print(sum);
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.red,
              height: 40,
              child: SizedBox(
                width: double.infinity,
                child: Text("Mwenda"),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  ElevatedButton(
                      child: Text("With Isolate- Spawn"),
                      onPressed: () async {
                        //ReceivePort is to listen for the isolate to finish job
                        final receivePort = ReceivePort();
                        // here we are passing method name and sendPort instance from ReceivePort as listener
                        await Isolate.spawn(computationallyExpensiveTaskSpawn,
                            receivePort.sendPort);

                        //It will listen for isolate function to finish
                        receivePort.listen((sum) {
                          print(sum);
                        });
                      }),
                ],
              ),
            ),
            Container(
              color: Colors.blueAccent,
              height: 40,
              child: SizedBox(
                width: double.infinity,
                child: Text("Mwenda"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int computationallyExpensiveTask(int value) {
  var sum = 0;
  for (var i = 0; i <= value; i++) {
    sum += i;
  }
  print("finished task");
  return sum;
}

// this function should be either top level(outside class) or static method
void computationallyExpensiveTaskSpawn(SendPort sendPort) {
  print("heavy work started");
  var sum = 0;
  for (var i = 0; i <= 1000000000; i++) {
    sum += i;
  }
  print("heavy work finished");
  //Remember there is no return, we are sending sum to listener defined defore.
  sendPort.send(sum);
}
