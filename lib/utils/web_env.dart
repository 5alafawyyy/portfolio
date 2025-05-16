import 'dart:js_interop';

@JS('window.env')
external JSObject get _env;

@JS()
extension EnvJSObjectExtension on JSObject {
  external JSString? SUPABASE_URL;
  external JSString? SUPABASE_ANON_KEY;
}

String getEnv(String key) {
  // Hardcoded access to known keys
  switch (key) {
    case 'SUPABASE_URL':
      return _env.SUPABASE_URL?.toDart ?? '';
    case 'SUPABASE_ANON_KEY':
      return _env.SUPABASE_ANON_KEY?.toDart ?? '';
    default:
      return '';
  }
}
