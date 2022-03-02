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
            SizedBox(height:50),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  ElevatedButton(
                    child: Text("Without Isolate"),
                    onPressed: () async{
                      final sum = computationallyExpensiveTask(1000000000);
                      print(sum);
                    },
                  ),
                ],
              ),
            ),
            Container(color: Colors.green,height: 40,child: SizedBox(width: double.infinity,child: Text("Evans"),),),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  ElevatedButton(
                    child: Text("With Isolate- Compute"),
                    onPressed: () async{
                      final sum =  await compute(computationallyExpensiveTask,1000000000);
                      print(sum);
                    },
                  ),
                ],
              ),
            ),
            Container(color: Colors.red,height: 40,child: SizedBox(width: double.infinity,child: Text("Mwenda"),),),

          ],
        ),
      ),
    );
  }
}

int computationallyExpensiveTask(int value){
  var sum = 0;
  for(var i=0;i<=value;i++){
    sum +=i;
  }
  print("finished task");
  return sum;
}
