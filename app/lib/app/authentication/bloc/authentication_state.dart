import 'package:equatable/equatable.dart';
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
  final String displayName;

  Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}

class Unauthenticated extends AuthenticationState {
  @override
  List<Object> get props => null;
  
  @override
  String toString() => 'Unauthenticated';
}