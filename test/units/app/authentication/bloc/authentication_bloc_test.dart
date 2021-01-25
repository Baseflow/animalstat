import 'package:animalstat/app/authentication/bloc/bloc.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
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

    if (authenticationBloc != null) {
      authenticationBloc.close();
    }

    mockUserRepository = null;
    authenticationBloc = null;
  });

  group('when \'AuthenticationBloc\' is constructed', () {
    test('should assert when no instance of the UserRepository is supplied',
        () {
      expect(
          () => AuthenticationBloc(userRepository: null), throwsAssertionError);
    });

    test('initialState should be `Uninitialized`', () {
      expect(authenticationBloc.state, Uninitialized());
    });
  });

  group('when receiving an \'AppStarted\' event', () {
    test('should call \'isSignedIn\' method on UserRepository exactly once.',
        () {
      final event = AppStarted();
      final user =
          User(id: '12345', email: 'test@example.com', companyId: 'my_company');

      expectLater(authenticationBloc, mayEmit(Authenticated(user)))
          .then((_) => verify(mockUserRepository.isSignedIn()).called(1));

      authenticationBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should emit [Authenticated] if user is already logged in.', () {
      final event = AppStarted();
      final user =
          User(id: '12345', email: 'test@example.com', companyId: 'my_company');
      final expected = [
        Authenticated(user),
      ];

      when(mockUserRepository.isSignedIn()).thenAnswer((_) => true);
      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc, emitsInOrder(expected));

      authenticationBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should call \'getUser\' method on UserRepository if user is already logged in.',
        () {
      final event = AppStarted();
      final user =
          User(id: '12345', email: 'test@example.com', companyId: 'my_company');

      when(mockUserRepository.isSignedIn()).thenAnswer((_) => true);
      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc, mayEmit(Authenticated(user)))
          .then((_) => verify(mockUserRepository.getUser()).called(1));

      authenticationBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should emit [Unauthenticated] when user is not logged in.', () {
      final event = AppStarted();
      final expected = [
        Unauthenticated(),
      ];

      when(mockUserRepository.isSignedIn()).thenAnswer((_) => false);

      expectLater(authenticationBloc, emitsInOrder(expected));

      authenticationBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should not call \'getUser\' method on UserRepository if user is not logged in.',
        () {
      final event = AppStarted();
      final user =
          User(id: '12345', email: 'test@example.com', companyId: 'my_company');

      when(mockUserRepository.isSignedIn()).thenAnswer((_) => false);
      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc, mayEmit(Authenticated(user)))
          .then((_) => verifyNever(mockUserRepository.getUser()));

      authenticationBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should emit [Unauthenticated] if an exception is thrown.', () {
      final event = AppStarted();
      final expected = [
        Unauthenticated(),
      ];

      when(mockUserRepository.isSignedIn()).thenThrow(Exception());

      expectLater(authenticationBloc, emitsInOrder(expected));

      authenticationBloc.add(event);
    });
  });

  group('when receiving a \'LoggedIn\' event', () {
    test('should emit [Authenticated] when logging in', () {
      final event = LoggedIn();
      final user =
          User(id: '12345', email: 'test@example.com', companyId: 'my_company');
      final expected = [
        Authenticated(user),
      ];

      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc, emitsInOrder(expected));

      authenticationBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should call \'getUser\' method on the supplied UserRepository exactly once',
        () {
      final event = LoggedIn();
      final user =
          User(id: '12345', email: 'test@example.com', companyId: 'my_company');

      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc, mayEmit(Authenticated(user)))
          .then((_) => verify(mockUserRepository.getUser()).called(1));

      authenticationBloc.add(event);
    });
  });

  group('when receiving a \'LoggedOut\' event', () {
    test('should emit [Unauthenticated].', () {
      final event = LoggedOut();
      final expected = [
        Unauthenticated(),
      ];

      expectLater(authenticationBloc, emitsInOrder(expected));

      authenticationBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should call \'signOut\' method on the supplied UserRepository exactly once.',
        () {
      final event = LoggedOut();

      expectLater(authenticationBloc, mayEmit(Unauthenticated()))
          .then((_) => verify(mockUserRepository.signOut()).called(1));

      authenticationBloc.add(event);
    });
  });
}
