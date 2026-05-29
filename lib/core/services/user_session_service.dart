import 'package:axis_crm/entity/user.dart';

class UserSessionService {
  User? _user;

  User? get user => _user;
  String? get userId => _user?.id;

  void setUser(User user) {
    _user = user;
  }

  void clear() {
    _user = null;
  }
}
