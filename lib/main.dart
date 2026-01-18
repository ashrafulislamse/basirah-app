import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Initialize Isar database
  // TODO: Initialize Firebase
  // TODO: Initialize location service
  // TODO: Request permissions

  runApp(
    const ProviderScope(
      child: BasirahApp(),
    ),
  );
}
