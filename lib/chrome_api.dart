@JS()
library chrome_api;

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('getSelectedText')
external Object _getSelectedText();

Future<String> getSelectedText() {
  return promiseToFuture(_getSelectedText());
}
