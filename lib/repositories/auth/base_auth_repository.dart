import 'package:photo/model/model.dart';

import '../repositories.dart';

abstract class BaseAuthRepository extends BaseRepository {
  Future<User> signUpWithEmailAndPassword({String email, String password});
  Future<User> loginWithEmailAndPassword({String email, String password});
  Future<void> logout();
  Future<User> getCurrentUser();
}
