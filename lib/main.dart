import 'dart:io';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Duration duration = const Duration(milliseconds: 2000);

  Color backgroundColor = Colors.orange;

  Icon icon = const Icon(Icons.repeat_outlined);

  Future<void> _pressHandler() async {
    _controller.forward();
    setState(() {
      backgroundColor = Colors.orange;
      icon = const Icon(Icons.repeat_outlined);
    });
    // after 1 second to reset animation.
    await Future.delayed(duration, () {
      _controller.reset();
      setState(() {
        backgroundColor = Colors.green;
        icon = const Icon(Icons.check);
      });
    });
    // set the origin icon and background color if need
    if (backgroundColor != Colors.orange ||
        icon != const Icon(Icons.repeat_outlined)) {
      await Future.delayed(duration, () {
        setState(() {
          backgroundColor = Colors.orange;
          icon = const Icon(Icons.repeat_outlined);
        });
      });
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var elevatedButton = ElevatedButton(
      onPressed: _pressHandler,
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20.0),
          primary: backgroundColor),
      child: icon,
    );

    var rotationTransition = RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: elevatedButton);

    return Scaffold(
      body: Center(
        child: rotationTransition,
      ),
    );
  }
}
