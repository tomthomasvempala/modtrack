import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subjectList.length,
            itemBuilder: (context, index1) {
              return Column(
                children: [
                  Text(subjectList[index1]["subjectCode"]),
                  Container(
                    width: 100,
                    height: 200,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index2) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                subjectList[index1]["modules"][index2] =
                                    (subjectList[index1]["modules"][index2] +
                                            1) %
                                        3;
                                setState(() {});
                                // subjectList[index1]["modules"][index2] =
                                //     subjectList[index1]["modules"][index2] == 0
                                //         ? 1
                                //         : 0;
                              },
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  color: subjectList[index1]["modules"]
                                              [index2] ==
                                          0
                                      ? Colors.red
                                      : subjectList[index1]["modules"]
                                                  [index2] ==
                                              1
                                          ? Colors.amber
                                          : Colors.green),
                            ),
                          );
                        }),
                  )
                ],
              );
            },
          ),
        ));
  }
}
