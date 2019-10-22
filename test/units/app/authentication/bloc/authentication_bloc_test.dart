import 'package:animal_stat/app/authentication/bloc/bloc.dart';
import 'package:animal_stat/app/user/user_repository.dart';
import 'package:animal_stat/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  // The unit under test
  AuthenticationBloc authenticationBloc;

  // Additional mocked dependencies
  MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();

    authenticationBloc = AuthenticationBloc(userRepository: mockUserRepository);
  });

  tearDown(() {
    clearInteractions(mockUserRepository);

    reset(mockUserRepository);

    mockUserRepository = null;
    authenticationBloc = null;
  });

  group('when \'AuthenticationBloc\' is constructed', () {

    test('should assert when no intance of the UserRespository is supplied', () {
      expect(() => AuthenticationBloc(userRepository: null), throwsAssertionError);
    });

    test('initialState should be `Uninitialized`', () {
      expect(authenticationBloc.initialState, Uninitialized());
    });
  });

  group('when receiving an \'AppStarted\' event', () {
    test('should call \'isSignedIn\' method on UserRepository exactly once.', () {
      final event = AppStarted();
      final user = User('Mr. Example', 'test@example.com');

      expectLater(authenticationBloc.state, mayEmit(Authenticated(user.name)))
          .then((_) => verify(mockUserRepository.isSignedIn()).called(1));

      authenticationBloc.dispatch(event);
    });

    test('should emit [Uninitialized, Authenticated] if user is already logged in.', () {
      final event = AppStarted();
      final user = User('Mr. Example', 'test@example.com');
      final expected = [
        Uninitialized(),
        Authenticated(user.name),
      ];

      when(mockUserRepository.isSignedIn()).thenAnswer((_) => Future.value(true));
      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc.state, emitsInOrder(expected));

      authenticationBloc.dispatch(event);
    });

    test('should call \'getUser\' method on UserRepository if user is already logged in.', () {
      final event = AppStarted();
      final user = User('Mr. Example', 'test@example.com');

      when(mockUserRepository.isSignedIn()).thenAnswer((_) => Future.value(true));
      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc.state, mayEmit(Authenticated(user.name)))
          .then((_) => verify(mockUserRepository.getUser()).called(1));

      authenticationBloc.dispatch(event);
    });

    test('should emit [Uninitialized, Unauthenticated] when user is not logged in.', () {
      final event = AppStarted();
      final expected = [
        Uninitialized(),
        Unauthenticated(),
      ];

      when(mockUserRepository.isSignedIn()).thenAnswer((_) => Future.value(true));

      expectLater(authenticationBloc.state, emitsInOrder(expected));

      authenticationBloc.dispatch(event);
    });

    test('should not call \'getUser\' method on UserRepository if user is not logged in.', () {
      final event = AppStarted();
      final user = User('Mr. Example', 'test@example.com');

      when(mockUserRepository.isSignedIn()).thenAnswer((_) => Future.value(false));
      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc.state, mayEmit(Authenticated(user.name)))
          .then((_) => verifyNever(mockUserRepository.getUser()));

      authenticationBloc.dispatch(event);
    });

    test('should emit [Uninitialized, Unauthenticated] if an exception is thrown.', () {
      final event = AppStarted();
      final expected = [
        Uninitialized(),
        Unauthenticated(),
      ];

      when(mockUserRepository.isSignedIn()).thenThrow(Exception());
      
      expectLater(authenticationBloc.state, emitsInOrder(expected));

      authenticationBloc.dispatch(event);
    });
  });

  group('when receiving a \'LoggedIn\' event', () {
    test('should emit [Uninitialized, Authenticated] when logging in', () {
      final event = LoggedIn();
      final user = User('Mr. Example', 'test@example.com');
      final expected = [
        Uninitialized(),
        Authenticated(user.name),
      ];

      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc.state, emitsInOrder(expected));

      authenticationBloc.dispatch(event);
    });

    test('should call \'getUser\' method on the supplied UserRepository exactly once', () {
      final event = LoggedIn();
      final user = User('Mr. Example', 'test@example.com');

      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc.state, mayEmit(Authenticated(user.name)))
          .then((_) => verify(mockUserRepository.getUser()).called(1));

      authenticationBloc.dispatch(event);
    });
  });

  group('when receiving a \'LoggedOut\' event', () {
    test('should emit [Uninitialized, Unauthenticated].', () {
      final event = LoggedOut();
      final expected = [
        Uninitialized(),
        Unauthenticated(),
      ];

      expectLater(authenticationBloc.state, emitsInOrder(expected));

      authenticationBloc.dispatch(event);
    });

    test('should call \'signOut\' method on the supplied UserRepository exactly once.', () {
      final event = LoggedOut();

      expectLater(authenticationBloc.state, mayEmit(Unauthenticated()))
          .then((_) => verify(mockUserRepository.signOut()).called(1));

      authenticationBloc.dispatch(event);
    });
  });
}
