import 'package:ai_page_summarizer_chrome_ext/chrome_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:js' as js;

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // query({"active": true, "currentWindow": true}, (tabs) {
    //   print(tabs);
    //   chrome.tabs.executeScript(
    //       tabs[0].id, {"code": "window.getSelection().toString();"},
    //       (selection) {
    //     var selectedText = selection;
    //     print(selectedText);
    //   });
    // });
    var queryInfo = js.JsObject.jsify({'active': true, 'currentWindow': true});
    var tabs = js.context['chrome']['tabs']?.callMethod('query', [
      queryInfo,
      (tabs) async {
        print('hogehoge');
        var url = tabs[0]['url'];
        var injection = js.JsObject.jsify({
          'target': tabs[0].id,
          'files': ["callback.js"],
        });
        // final script = js.JsObject.jsify(
        //     {'code': 'console.log("Hello from content script!");'});
        // final jsFunction =
        //     'function hoge(){ console.log("Hello from content script!");}';
        // js.context.callMethod('eval', [jsFunction]);
        // js.JsFunction jsHogeFunction = js.context['hoge'];

        // final script = js.JsObject.jsify(
        //     {'code': 'console.log("Hello from content script!");'});
        // js.context['chrome']['scripting']?.callMethod('executeScript', [
        //   injection,
        //   js.JsFunction.withThis((js.JsObject result, _) {
        //     print('script returned: $result');
        //   })
        // ]);

        // final scr = js.context['chrome']['tabs'];

        // js.context['chrome']['scripting'].callMethod('executeScript', [
        //   injection,
        // ]);
      }
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: Text("hoge"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
