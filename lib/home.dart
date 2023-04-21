import 'package:ai_page_summarizer_chrome_ext/chrome_api.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/src/framework.dart';

enum TargetLanguage {
  japanese,
  english,
}

final targetLanguageProvider = FutureProvider<TargetLanguage>((ref) async {
  final language = await getLanguage();
  switch (language) {
    case "":
      return TargetLanguage.english;
    case "english":
      return TargetLanguage.english;
    case "japanese":
      return TargetLanguage.japanese;
    default:
      return TargetLanguage.english;
  }
});

final myFutureProvider = FutureProvider<String>((ref) async {
  print("myfutureprovider");
  final targetLanguage = await ref.watch(targetLanguageProvider.future);
  final result = await getSelectedText().catchError((err) {
    if (err.toString() == "no text selection") {
      return "";
    }

    print("error occurred while getting selected text.");
    throw Exception("Error occurred while getting selected text. err: $err");
  });
  if (result == "") {
    print("no text selected.");
    return "No text selected, nothing to summarize.";
  }
  print("selected language is $targetLanguage");
  final content = targetLanguage == TargetLanguage.english
      ? "Please summarize the following content in English.\n $result"
      : "次に続く文章を日本語で要約してください:\n $result";
  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: content,
        role: OpenAIChatMessageRole.user,
      ),
    ],
  );
  final response = chatCompletion.choices[0].message.content;
  return response;
});

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("OpenAI Summarizer")),
      body: Center(
        child: _body(context, ref),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(myFutureProvider);
    return provider.when(
      data: (data) => _data(context, ref, data),
      error: (err, stackTrace) => _error(context, err),
      loading: () => _loading(context, ref),
    );
  }

  Widget _data(BuildContext context, WidgetRef ref, String data) {
    print("received data is $data");
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        data == "" ? "no text selection" : data,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _loading(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Spacer(),
        Text(
          "Summarizing selected text...",
          style: TextStyle(fontSize: 16),
        ),
        Spacer(),
        CircularProgressIndicator(),
        Spacer(),
      ],
    );
  }

  Widget _error(BuildContext context, Object error) {
    return Column(
      children: [
        const Spacer(),
        const Text(
          "Something wrong, did you register your OpenAI API KEY on options page?",
        ),
        const Spacer(),
        Text(
          "err: $error",
        ),
        const Spacer(),
      ],
    );
  }
}
