import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class IntroBlurb extends StatelessWidget {
  const IntroBlurb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // child: const Text('This app is part of a project demonstrating CI/CD for Flutter + Firebase web apps (PWAs).'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              text: 'This app is part of a project demonstrating CI/CD for Flutter + Firebase web apps (PWAs). This is a Hackathon Onboarding Project (HOP) for ',
            ),
            TextSpan(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.lightBlue,
                  ),
              text: 'commit.dev',
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launch('https://commit.dev', forceSafariVC: false);
                },
            ),
            // TextSpan(
            //   style: Theme.of(context).textTheme.bodyMedium,
            //   text: 'more text',
            // ),
          ],
        ),
      ),
    );
  }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const IntroBlurb(),
            if (!kDebugMode) const Image(image: AssetImage('commit-logo.webp'), height: 100),
            const SizedBox(height: 50),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
