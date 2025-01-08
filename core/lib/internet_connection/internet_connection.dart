import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';

class InternetConnection {
  InternetConnection();

  static Future<bool> isInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.isEmpty ||
        connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    try {
      final Response<Map<String, dynamic>> response = await Dio().get(AppStrings.baseUrl,
          options: Options(
            validateStatus: (int? status) => status! >= 200 && status < 300,
          ));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
