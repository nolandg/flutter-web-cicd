import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroBlurb extends StatelessWidget {
  const IntroBlurb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Container(
      padding: const EdgeInsets.all(16),
      // child: const Text('This app is part of a project demonstrating CI/CD for Flutter + Firebase web apps (PWAs).'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'This app is part of a project demonstrating CI/CD for Flutter + Firebase web apps (PWAs). This is a Hackathon Onboarding Project (HOP) for ', style: textStyle),
            TextSpan(
              text: 'commit.dev',
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launch('https://commit.dev');
                },
              style: textStyle.copyWith(
                color: Colors.lightBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
