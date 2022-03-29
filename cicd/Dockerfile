# Based on official Circleci image which includes Chrome and Firefox
FROM cimg/node:17.8.0-browsers AS build

# Install Flutter (source: https://docs.flutter.dev/get-started/install/linux)
WORKDIR /home/circleci
RUN wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.4-stable.tar.xz
RUN tar xf flutter_linux_2.10.4-stable.tar.xz


FROM cimg/node:17.8.0-browsers AS run
# Copy Flutter from build and set it up
ENV PATH="$PATH:/home/circleci/flutter/bin"
WORKDIR /home/circleci
COPY --from=build /home/circleci/flutter flutter
RUN flutter precache --web

# Install Firebase
RUN curl -sL https://firebase.tools | bash