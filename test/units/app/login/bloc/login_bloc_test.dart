import 'package:animalstat/app/login/bloc/bloc.dart';
import 'package:animalstat/app/login/bloc/login_event.dart';
import 'package:animalstat/app/login/bloc/login_state.dart';
import 'package:animalstat/src/utilities/validators.dart';
import 'package:animalstat_repository/animalstat_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockValidators extends Mock implements Validators {}

void main() {
  // The unit under test
  LoginBloc loginBloc;

  // Additional mocked dependencies
  MockUserRepository mockUserRepository;
  MockValidators mockValidators;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockValidators = MockValidators();

    loginBloc = LoginBloc(
      userRepository: mockUserRepository,
      validators: mockValidators,
    );
  });

  tearDown(() {
    clearInteractions(mockUserRepository);
    clearInteractions(mockValidators);

    reset(mockUserRepository);
    reset(mockValidators);

    if (loginBloc != null) {
      loginBloc.close();
    }

    mockUserRepository = null;
    mockValidators = null;
    loginBloc = null;
  });

  group('when \'LoginBloc\' is constructed', () {
    test(
        // ignore: lines_longer_than_80_chars
        'should assert when no intance of the UserRespository class is supplied',
        () {
      expect(
          () => LoginBloc(
                userRepository: null,
                validators: mockValidators,
              ),
          throwsAssertionError);
    });

    test('should assert when no intance of the Validators class is supplied',
        () {
      expect(
          () => LoginBloc(
                userRepository: mockUserRepository,
                validators: null,
              ),
          throwsAssertionError);
    });

    test('initialState should be `empty`', () {
      expect(loginBloc.state, LoginState.empty());
    });
  });

  group('when receiving an \'emailChanged\' event', () {
    test('should emit LoginState where isValidEmail is true.', () {
      const email = '';
      final currentState = LoginState.empty();
      final event = EmailChanged(email: email);
      final expected = [currentState];

      when(mockValidators.isValidEmail(email)).thenAnswer((_) => true);

      expectLater(loginBloc, emitsInOrder(expected));

      loginBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should emit an empty LoginState and updated state where isValidEmail is false.',
        () {
      const email = '';
      final currentState = LoginState.empty();
      final event = EmailChanged(email: email);
      final expected = [
        currentState.update(isEmailValid: false),
      ];

      when(mockValidators.isValidEmail(email)).thenAnswer((_) => false);

      expectLater(loginBloc, emitsInOrder(expected));

      loginBloc.add(event);
    });
  });

  group('when receiving an \'passwordChanged\' event', () {
    test('should emit LoginState where isValidPassword is true.', () {
      const password = '';
      final currentState = LoginState.empty();
      final event = PasswordChanged(password: password);
      final expected = [currentState];

      when(mockValidators.isValidPassword(password)).thenAnswer((_) => true);

      expectLater(loginBloc, emitsInOrder(expected));

      loginBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should emit an empty LoginState and updated state where isValidPassword is false.',
        () {
      const password = '';
      final currentState = LoginState.empty();
      final event = PasswordChanged(password: password);
      final expected = [
        currentState.update(isPasswordValid: false),
      ];

      when(mockValidators.isValidPassword(password)).thenAnswer((_) => false);

      expectLater(loginBloc, emitsInOrder(expected));

      loginBloc.add(event);
    });
  });

  group('when receiving an \'LoginWithCredentialsPressed\' event', () {
    test('should emit LoadingState.', () {
      final event = LoginWithCredentialsPressed(email: '', password: '');
      final expected = [LoginState.loading()];

      expectLater(loginBloc, emitsInOrder(expected));

      loginBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'should emit \'LoginState.loading()\' state and call \'UserRepository.signInWithCredentials\' exactly once.',
        () {
      const email = '';
      const password = '';
      final event =
          LoginWithCredentialsPressed(email: email, password: password);
      final expected = [LoginState.loading()];

      when(mockUserRepository.signInWithCredentials(email, password))
          .thenAnswer((_) => Future.value());

      expectLater(loginBloc, emitsInOrder(expected)).then((_) =>
          verify(mockUserRepository.signInWithCredentials(email, password))
              .called(1));

      loginBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'with valid credentials, should emit an [LoginState.empty(), LoginState.loading(), LoginState.success()].',
        () {
      const email = '';
      const password = '';
      final event =
          LoginWithCredentialsPressed(email: email, password: password);
      final expected = [
        LoginState.loading(),
        LoginState.success(),
      ];

      when(mockUserRepository.signInWithCredentials(email, password))
          .thenAnswer((_) => Future.value());

      expectLater(loginBloc, emitsInOrder(expected));

      loginBloc.add(event);
    });

    test(
        // ignore: lines_longer_than_80_chars
        'with invalid credentials, should emit an [LoginState.empty(), LoginState.loading(), LoginState.failure()].',
        () {
      const email = '';
      const password = '';
      final event =
          LoginWithCredentialsPressed(email: email, password: password);
      final expected = [
        LoginState.loading(),
        LoginState.failure(),
      ];

      when(mockUserRepository.signInWithCredentials(email, password))
          .thenThrow(Error());

      expectLater(loginBloc, emitsInOrder(expected));

      loginBloc.add(event);
    });
  });
}
