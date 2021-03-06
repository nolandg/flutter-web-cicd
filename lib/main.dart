import 'dart:convert';
import 'dart:typed_data';
import 'package:cicd_tutorial/IntroBlurb.dart';
import 'package:cicd_tutorial/PostsList.dart';
import 'package:cicd_tutorial/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_ui/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter + Firebase CI/CD Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Uint8List logoBytes = const Base64Decoder().convert('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');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromRGBO(254, 106, 184, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.memory(logoBytes, height: 100),
          const IntroBlurb(),
          const AuthStatus(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  width: 600,
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(20),
                  child: const SignInScreen(
                    providerConfigs: [
                      EmailProviderConfiguration(),
                      GoogleProviderConfiguration(clientId: '737150762289-dgrkm8i9rnh5d03fm51tuk9pddoim9hd.apps.googleusercontent.com')
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text('Posts:', style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 16),
                    PostsList(),
                  ],
                ),
              ),
            ],
          ),
          const Text('You have pushed the button this many times:'),
          Text('$_counter', style: Theme.of(context).textTheme.headline4),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
