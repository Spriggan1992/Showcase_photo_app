import 'package:equatable/equatable.dart';
import 'package:photo/entities/user_entity.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String nickname;

  User({this.id, this.email, this.nickname});

  @override
  List<Object> get props => [id, email, nickname];

  @override
  String toString() => '''User{
    id: $id,
    email: $email,
    nickname: $nickname,
  }''';

  UserEntity toEntity() {
    return UserEntity(id: id, email: email, nickname: nickname);
  }

  factory User.fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      email: entity.email,
      nickname: entity.nickname,
    );
  }
}
