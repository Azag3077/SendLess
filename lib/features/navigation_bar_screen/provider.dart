// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
//
// import '../../../../utils/providers.dart';
// import '../../core/services/fcm_helper.dart';
// import '../../core/services/geolocator_handler.dart';
// import '../../data/network/api_services/user.dart';
//
// class _Notifier extends AutoDisposeNotifier<int> {
//   final _geolocatorHandler = GeolocatorHandler();
//
//   // final _notificationHandler = NotificationHandler();
//
//   @override
//   int build() {
//     ref.onDispose(_geolocatorHandler.onDispose);
//     _initState();
//     return 0;
//   }
//
//   Future<void> _initState() async {
//     await Future.delayed(const Duration(seconds: 1));
//     await notificationPermission();
//     await geolocatorPermission();
//   }
//
//   Future<void> geolocatorPermission() async =>
//       await _geolocatorHandler.getPositionStream(_updateUserCoordinate);
//
//   Future<void> notificationPermission() async => await FCMHelper.initialize();
//
//   Future<void> _updateUserCoordinate(Position? position) async {
//     ref.read(positionStateProvider.notifier).state = position;
//     final isGuest = ref.watch(userProfileProvider)!.isGuest;
//     if (isGuest || position == null) return;
//
//     await UserApiService.updateCoordinates(position);
//   }
//
//   void updatePageIndex(int index) => state = index;
// }
//
// final navigationScreenProvider =
//     AutoDisposeNotifierProvider<_Notifier, int>(_Notifier.new);
