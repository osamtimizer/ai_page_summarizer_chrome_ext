@JS()
library chrome_api;

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('getSelectedText')
external Object _getSelectedText();

Future<String> getSelectedText() {
  return promiseToFuture(_getSelectedText());
}

@JS('getSavedApiKey')
external Object _getSavedApiKey();
Future<String> getSavedApiKey() {
  return promiseToFuture(_getSavedApiKey());
}

@JS('getLanguage')
external Object _getLanguage();
Future<String> getLanguage() {
  return promiseToFuture(_getLanguage());
}
