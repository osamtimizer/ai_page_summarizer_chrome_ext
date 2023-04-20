import 'package:ai_page_summarizer_chrome_ext/chrome_api.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myFutureProvider = FutureProvider<String>((ref) async {
  final result = await getSelectedText();
  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: result,
        role: OpenAIChatMessageRole.user,
      ),
    ],
  );
  return result;
});

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(myFutureProvider);
    return provider.when(
      data: (data) => Text(data),
      error: (err, stackTrace) => Text("err: $err"),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
