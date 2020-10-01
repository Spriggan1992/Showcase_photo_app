import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String nickname;

  UserEntity({this.id, this.email, this.nickname});
  @override
  List<Object> get props => [id, email, nickname];

  @override
  String toString() => '''UserEntity {
    id: $id,
    email: $email,
    nickname: $nickname
   
  }''';

  Map<String, dynamic> toDocument() {
    return {'email': email};
  }

  factory UserEntity.fromSnapshot(DocumentSnapshot doc) {
    return UserEntity(
      id: doc.id,
      email: doc.data()['email'] ?? '',
      nickname: doc.data()['nickname'] ?? '',
    );
  }
}
