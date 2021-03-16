#!/bin/bash

flutter upgrade

cd ..
flutter packages upgrade
flutter pub outdated


flutter clean
#flutter run --verbose
