import 'package:teslo_shop/features/auth/domain/domain.dart';
import '../infraestructure.dart';

class AuthRepositoryInfraestructure extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryInfraestructure({AuthDatasource? authDatasource})
      : authDatasource = authDatasource ?? AuthDatasourceInfraestructure();

  @override
  Future<User> checkAuthStatus(String token) {
    return authDatasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return authDatasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return authDatasource.register(email, password, fullName);
  }
}
