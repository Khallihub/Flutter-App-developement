import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/domain/entities/signup/sign_up_model.dart';
import 'package:picstash/infrastructure/data_providers/signup/signup_data_provider.dart';

class SignUpRepository {
  final SignUpDataProvider signUpDataProvider;

  const SignUpRepository({required this.signUpDataProvider});

  Future<LoginDetailsModel> signup(SignUpModel signUpModel) {
    return signUpDataProvider.signup(signUpModel);
  }
}
