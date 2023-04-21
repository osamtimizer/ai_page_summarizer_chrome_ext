import 'package:ai_page_summarizer_chrome_ext/chrome_api.dart';
import 'package:ai_page_summarizer_chrome_ext/main_app.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  final apiKey = await getSavedApiKey();
  print("your api key is $apiKey");
  OpenAI.apiKey = apiKey;
  runApp(const ProviderScope(child: MainApp()));
}
