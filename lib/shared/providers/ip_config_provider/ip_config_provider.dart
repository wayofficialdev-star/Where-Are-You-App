import 'dart:convert' as convert;
import 'dart:developer';

import 'package:app/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ip_config_provider.g.dart';

/// Resolves the visitor's country so the app can apply country-specific UX
/// (phone number dial code, currency, ...).
///
/// The IPInfo token is **not** stored in source control; it is passed at build
/// time via `--dart-define=IPINFO_TOKEN=...`. When it is missing the lookup is
/// skipped and an empty [IPModel] is returned so startup is never blocked.
@Riverpod(keepAlive: true)
Future<IPModel> ipConfig(IpConfigRef ref) async {
  final env = ref.watch(envProvider);
  final token = env.IPINFO_TOKEN;

  if (token.isEmpty) {
    log('IPINFO_TOKEN is not configured; skipping IP lookup.');
    return const IPModel();
  }

  try {
    final url = Uri.https('ipinfo.io', '/', {'token': token});
    final response = await http
        .get(url, headers: {'Referer': 'https://example.com'})
        .timeout(env.CONNECT_TIMEOUT);

    return IPModel.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>,
    );
  } catch (e) {
    log('IP lookup failed: ${e.runtimeType}');
    return const IPModel();
  }
}
