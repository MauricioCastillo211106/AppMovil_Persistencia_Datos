import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkService extends GetxService {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((status) {
      _checkConnectivity();
    });
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    isConnected.value = connectivityResult != ConnectivityResult.none;
  }
}
