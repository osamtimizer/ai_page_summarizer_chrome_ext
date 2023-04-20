import 'package:ai_page_summarizer_chrome_ext/chrome_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myFutureProvider = FutureProvider<String>((ref) async {
  print("myfutureprovider");
  final result = await getSelectedText();
  print(result);
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
