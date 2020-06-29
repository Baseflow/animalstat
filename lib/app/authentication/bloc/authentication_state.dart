import 'package:equatable/equatable.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {  
  @override
  List<Object> get props => null;

  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { user: $user }';
}

class Unauthenticated extends AuthenticationState {
  @override
  List<Object> get props => null;
  
  @override
  String toString() => 'Unauthenticated';
}