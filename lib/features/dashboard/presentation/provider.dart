import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider =
    AutoDisposeNotifierProvider<_Notifier, int>(_Notifier.new);

class _Notifier extends AutoDisposeNotifier<int> {
  @override
  int build() {
    ref.onDispose(_onDispose);
    return 0;
  }

  void _onDispose() {}

  void updatePageIndex(int value) => state = value;
}
