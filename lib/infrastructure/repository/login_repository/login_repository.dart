import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/domain/entities/login/login_model.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
import 'package:picstash/infrastructure/data_providers/login/login_data_provider.dart';

class LoginRepository {
  final LoginDataProvider loginDataProvider;

  LoginRepository({required this.loginDataProvider});

  Future<LoginDetailsModel> login(LoginModel loginModel) async {
    return loginDataProvider.login(loginModel);
  }

  Future<void> logout(LoginCredentials loginCredentials) async {
    LoginDetailsModel? loginDetailsModel =
        await loginCredentials.getLoginCredentials();
    loginDataProvider.logout(loginDetailsModel!);
    await loginCredentials.deleteLoginCredentials();
  }
}
