import 'package:app/features/find_someone/domain/find_someone_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'find_someone_notifier.g.dart';

/// Search term entered on the Find Someone screen.
final findSomeoneQueryProvider = StateProvider<String>((ref) => '');

/// People available to meet, filtered by [findSomeoneQueryProvider].
@Riverpod()
class FindSomeoneNotifier extends _$FindSomeoneNotifier {
  @override
  Future<List<NearbyPerson>> build() {
    final query = ref.watch(findSomeoneQueryProvider);

    return ref.watch(findSomeoneRepoProvider).search(query);
  }
}
