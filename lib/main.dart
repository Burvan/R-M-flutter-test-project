import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'app/rick_and_morty_app.dart';

Future<void> main() async{
  appDI.init();
  await dataDI.setupAppLocator();
  runApp(const RickAndMortyApp());
}

