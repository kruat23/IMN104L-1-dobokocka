import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opencv/opencv.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  File file;
  Image image = Image.asset('assets/images/temp.png');
  Image imageWithCircles = Image.asset('assets/images/temp.png');
  dynamic res;




  @override
  void initState(){
    super.initState();
    loadImage();
  }

    Future loadImage() async {
      file = await DefaultCacheManager().getSingleFile("https://raw.githubusercontent.com/Tomikoma/IMN104L-1-dobokocka/master/images/dice.jpg");
      res = await ImgProc.cvtColor(await file.readAsBytes(), 6);
      //res = await ImgProc.adaptiveThreshold(await file.readAsBytes(), 125, ImgProc.adaptiveThreshMeanC, ImgProc.threshBinary, 11, 12);
      res = await ImgProc.houghCircles(await res, ImgProc.houghGradient, 1, 15, 200, 20, 10, 30);
      //ImgProc.houghCircles(byteData, method, dp, minDist, param1, param2, minRadius, maxRadius)
    setState(() {
      image = Image.file(file);
      imageWithCircles = Image.memory(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: [
        image,
        imageWithCircles
      ],)
      ,
      
    );
  }
}
