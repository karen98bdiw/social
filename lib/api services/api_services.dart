import 'package:social/api%20services/auth_services.dart';

class Api {
  static final Api _api = Api._internal();
  final Auth auth = Auth();
  Api._internal();

  factory Api() {
    return _api;
  }
}
