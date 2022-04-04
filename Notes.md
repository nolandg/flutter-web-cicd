Keep Docker container running with a foreground process:
docker run cimg/node:17.8.0-browsers tail -f /dev/null

Integration test instructions: https://docs.flutter.dev/cookbook/testing/integration/introduction

Firebase CI login: https://firebase.google.com/docs/cli#cli-ci-systems

Custom Circleci images: https://circleci.com/docs/2.0/custom-images/
Ciurcle env vars: https://circleci.com/docs/2.0/env-vars/

// Flutter web integration testing is in the weeds: https://github.com/flutter/flutter/issues/86985
git repository
How to use your fork as a Flutter dep:
1. Fork and clone repo
2. Checkout the exact tag you're using: `git checkout tags/2.10.4 -b fix-screenshots`
3. Make the fix, commit, and push
4. Update `pubspec.yaml` to reference the fixed branch of your fork:
    ```yaml
        dev_dependencies:
          flutter_test:
            sdk: flutter
          integration_test:
            git:
              url: https://github.com/nolandg/flutter
              path: packages/integration_test
              ref: fix-screenshots
    ```


firebase init

firebase hosting:
 "hosting": {
    "public": "build/web", <----- !



To Think about:
  - We're testing a debug build with test instrumentation, never testing production build
  - Put firebase stuff in sub dir, too messy especially with node_modules

this don't work for web: https://stackoverflow.com/questions/59028609/how-to-find-if-we-are-running-unit-test-in-dart-flutter/59028868

Coverage: vscode extension

hard: widget testing because of HTTP access and assets etc.

Flutterfire tooling is getting better fast
