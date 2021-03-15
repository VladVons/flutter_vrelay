#!/bin/bash

flutter upgrade

cd ..
flutter pub outdated
flutter packages upgrade
