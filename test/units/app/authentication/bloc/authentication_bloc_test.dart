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

  group('initialState tests', () {
    test('initialState should be `Uninitialized`', () {
      expect(authenticationBloc.initialState, Uninitialized());
    });
  });

  group('AppStarted event tests', () {});

  group('LoggedIn event tests', () {
    test('emits [Uninitialized, Authenticated] when logging in', () {
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

    test('calls \'getUser\' method on the supplied UserRepository exactly once', () {
      final event = LoggedIn();
      final user = User('Mr. Example', 'test@example.com');

      when(mockUserRepository.getUser()).thenAnswer((_) => Future.value(user));

      expectLater(authenticationBloc.state, mayEmit(Authenticated(user.name)))
          .then((_) => verify(mockUserRepository.getUser()).called(1));

      authenticationBloc.dispatch(event);
    });
  });

  group('LoggedOut event tests', () {
    test('emits [Uninitialized, Unauthenticated] when logging out', () {
      final event = LoggedOut();
      final expected = [
        Uninitialized(),
        Unauthenticated(),
      ];

      expectLater(authenticationBloc.state, emitsInOrder(expected));

      authenticationBloc.dispatch(event);
    });

    test('calls \'signOut\' method on the supplied UserRepository exactly once', () {
      final event = LoggedOut();

      expectLater(authenticationBloc.state, mayEmit(Unauthenticated()))
          .then((_) => verify(mockUserRepository.signOut()).called(1));

      authenticationBloc.dispatch(event);
    });
  });
}
