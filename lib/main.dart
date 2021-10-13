import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'fetchData.dart';
import 'subjects.dart';

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
      home: MyHomePage(title: 'Module status '),
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
  void initState() {
    gettingmyData();
  }

  void gettingmyData() async {
    List mysubjects = await getData();
    if (mysubjects == []) {
      return;
    } else {
      subjectList = mysubjects;
      print("data loaded");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(subjectList[index1]["subjectCode"]),
                  Container(
                    width: (pageSize.width - 2) / 6,
                    height: pageSize.height / 1.5,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index2) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: () {
                                subjectList[index1]["modules"][index2] =
                                    (subjectList[index1]["modules"][index2] +
                                            1) %
                                        3;
                                setState(() {});
                                setData(subjectList);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("${index2 + 1}"),
                                  width: (pageSize.width - 32) / 8,
                                  height: (pageSize.width - 2) / 8,
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
