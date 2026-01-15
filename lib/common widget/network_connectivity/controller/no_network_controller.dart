import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  final RxBool isConnected = true.obs;

  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkInitial();

    _subscription =
        _connectivity.onConnectivityChanged.listen((results) async {
          await _updateStatus(results);
        });
  }

  /// Initial check
  Future<void> _checkInitial() async {
    final results = await _connectivity.checkConnectivity();
    await _updateStatus(results);
  }

  /// Main logic
  Future<void> _updateStatus(List<ConnectivityResult> results) async {
    final hasNetwork =
    !results.contains(ConnectivityResult.none);

    if (!hasNetwork) {
      isConnected.value = false;
      return;
    }

    /// 🔥 REAL INTERNET CHECK
    final hasInternet = await _hasInternetAccess();
    isConnected.value = hasInternet;
  }

  /// Internet ping check
  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
