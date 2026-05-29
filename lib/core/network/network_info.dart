import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Kiểm tra kết nối internet thực sự (không chỉ dựa vào WiFi/mobile).
///
/// Được inject vào [NetworkGuardInterceptor] — interceptor đầu tiên trong chain,
/// chặn request trước khi nó ra mạng nếu không có kết nối.
///
/// Dùng trong DI:
/// ```dart
/// sl.registerLazySingleton<NetworkInfo>(
///   () => NetworkInfoImpl(sl<Connectivity>()),
/// );
/// ```
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Hai bước kiểm tra:
/// 1. `connectivity_plus` — nhanh, nhưng chỉ cho biết có kết nối WiFi/mobile,
///    không đảm bảo có internet thực.
/// 2. DNS lookup `google.com` — xác nhận internet thật, timeout 5 giây.
///    Nếu cả hai đều pass → online.
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectivity);
  final Connectivity connectivity;

  @override
  Future<bool> get isConnected async {
    final List<ConnectivityResult> result =
        await connectivity.checkConnectivity();

    if (result.contains(ConnectivityResult.none)) return false;

    try {
      final List<InternetAddress> lookup =
          await InternetAddress.lookup('google.com')
              .timeout(const Duration(seconds: 5));
      return lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
