# Based on official Circleci image which includes Chrome and Firefox
FROM cimg/node:17.8.0-browsers

# Install Flutter (source: https://docs.flutter.dev/get-started/install/linux)
WORKDIR /home/circleci
RUN wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.4-stable.tar.xz
RUN tar xf flutter_linux_2.10.4-stable.tar.xz
ENV PATH="$PATH:/home/circleci/flutter/bin"
RUN flutter precache --web