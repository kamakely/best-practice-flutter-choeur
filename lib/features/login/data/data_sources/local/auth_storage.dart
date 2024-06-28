import '../../../../../core/constants/constants.dart';
import '../../../../../framework/storage/storage.dart';

class AuthStorage {
  Storage storage = Storage();

  String? getToken() => storage.getValue<String?>(
        Constants.authToken,
      );

  bool? getIsAuthentificated() => storage.getValue<bool?>(
        Constants.isAuthenticated,
      );

  void setToken(String? value) => storage.setValue<String?>(
        Constants.authToken,
        value,
      );

  void setIsAuthentificated(bool value) => storage.setValue<bool>(
        Constants.isAuthenticated,
        value,
      );
}
