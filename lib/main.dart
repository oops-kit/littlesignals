import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:littlesignals/app.dart';
import 'package:littlesignals/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 웹에서 URL 전략을 path 기반으로 설정 (# 제거)
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: LittleSignalsApp()));
}
