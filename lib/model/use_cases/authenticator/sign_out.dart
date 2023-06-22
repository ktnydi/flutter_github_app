import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/shared_preferences_provider.dart';

final signOut = Provider<Future<bool> Function()>((ref) {
  return () async {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.remove('accessToken');
  };
});
