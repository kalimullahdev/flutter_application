import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/core/sqflite_database.dart';
import 'package:flutter_application/presentation/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SQFLiteDatabase sqfLiteDatabase = SQFLiteDatabase();
  await sqfLiteDatabase.init();
  runApp(
    ProviderScope(
      child: App(database: sqfLiteDatabase.instance),
    ),
  );
}
