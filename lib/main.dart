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
    print("yo $mysubjects");
    if (mysubjects.length == 0) {
      return;
    } else {
      subjectList = mysubjects;
      print("ho $subjectList");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print(subjectList.length);
    Size pageSize = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: gettingmyData,
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subjectList.length,
              itemBuilder: (context, index1) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(subjectList[index1]["subjectCode"]),
                    Container(
                      width: (pageSize.width - 2) / 6,
                      height: pageSize.height - 150,
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
                                  print("keri");
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
          ),
        ));
  }
}
