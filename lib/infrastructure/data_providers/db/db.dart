import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/domain/entities/user_model.dart';
import 'package:picstash/domain/value_objects/acess_token.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCredentials {
  Future<SharedPreferences> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  void insertLoginCredentials(LoginDetailsModel loginDetailsModel) async {
    final SharedPreferences prefs = await init();
    prefs.setString("access_token", loginDetailsModel.token.accessToken);
    prefs.setString('refresh_token', loginDetailsModel.token.refreshToken);
    prefs.setString("role", loginDetailsModel.role);
    prefs.setString("id", loginDetailsModel.user.id);
    prefs.setString("name", loginDetailsModel.user.name);
    prefs.setString("email", loginDetailsModel.user.email.toString());
    prefs.setString("username", loginDetailsModel.user.username);
  }

  Future<LoginDetailsModel?> getLoginCredentials() async {
    final SharedPreferences prefs = await init();
    String? accessToken = prefs.getString("access_token");
    String? refreshToken = prefs.getString("refresh_token");
    String? role = prefs.getString("role");
    String? id = prefs.getString("id");
    String? name = prefs.getString("name");
    String? email = prefs.getString("email");
    String? username = prefs.getString("username");

    if (id != null &&
        accessToken != null &&
        refreshToken != null &&
        role != null &&
        name != null &&
        email != null &&
        username != null) {
      User user = User(
          id: id,
          name: name,
          email: EmailAddress.crud(email),
          username: username);

      return LoginDetailsModel.create(
          Token.create(accessToken, refreshToken), role, user);
    }
    return null;
  }

  Future<void> deleteLoginCredentials() async {
    final SharedPreferences prefs = await init();
    prefs.remove("access_token");
    prefs.remove("referesh_token");
    prefs.remove("role");
    prefs.remove("id");
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("username");
  }
}
