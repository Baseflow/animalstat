import 'package:livestock/app/login/bloc/bloc.dart';
import 'package:livestock/app/login/bloc/login_event.dart';
import 'package:livestock/app/login/bloc/login_state.dart';
import 'package:livestock/src/utilities/validators.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livestock_repository/livestock_repository.dart';
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

    if(loginBloc != null) {
      loginBloc.close();
    }

    mockUserRepository = null;
    mockValidators = null;
    loginBloc = null;
  });

  group('when \'LoginBloc\' is constructed', () {
    test(
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
      expect(loginBloc.initialState, LoginState.empty());
    });
  });

  group('when receiving an \'emailChanged\' event', () {
    test('should emit LoginState where isValidEmail is true.', () {
      final email = '';
      final currentState = LoginState.empty();
      final event = EmailChanged(email: email);
      final expected = [
        currentState
      ];

      when(mockValidators.isValidEmail(email)).thenAnswer((_) => true);

      expectLater(loginBloc.state, emitsInOrder(expected));

      loginBloc.add(event);
    });

    test('should emit an empty LoginState and updated state where isValidEmail is false.', () {
      final email = '';
      final currentState = LoginState.empty();
      final event = EmailChanged(email: email);
      final expected = [
        currentState,
        currentState.update(isEmailValid: false),
      ];

      when(mockValidators.isValidEmail(email)).thenAnswer((_) => false);

      expectLater(loginBloc.state, emitsInOrder(expected));

      loginBloc.add(event);
    });
  });

  group('when receiving an \'passwordChanged\' event', () {
    test('should emit LoginState where isValidPassword is true.', () {
      final password = '';
      final currentState = LoginState.empty();
      final event = PasswordChanged(password: password);
      final expected = [
        currentState
      ];

      when(mockValidators.isValidPassword(password)).thenAnswer((_) => true);

      expectLater(loginBloc.state, emitsInOrder(expected));

      loginBloc.add(event);
    });

    test('should emit an empty LoginState and updated state where isValidPassword is false.', () {
      final password = '';
      final currentState = LoginState.empty();
      final event = PasswordChanged(password: password);
      final expected = [
        currentState,
        currentState.update(isPasswordValid: false),
      ];

      when(mockValidators.isValidPassword(password)).thenAnswer((_) => false);

      expectLater(loginBloc.state, emitsInOrder(expected));

      loginBloc.add(event);
    });
  });

  group('when receiving an \'LoginWithCredentialsPressed\' event', () {
    test('should emit LoadingState.', () {
      final event = LoginWithCredentialsPressed(email: '', password: '');
      final expected = [
        LoginState.empty(),
        LoginState.loading()
      ];

      expectLater(loginBloc.state, emitsInOrder(expected));

      loginBloc.add(event);
    });

    test('should emit \'LoginState.loading()\' state and call \'UserRepository.signInWithCredentials\' exactly once.', () {
      final email = '';
      final password = '';
      final event = LoginWithCredentialsPressed(email: email, password: password);
      final expected = [
        LoginState.empty(),
        LoginState.loading()
      ];

      when(mockUserRepository.signInWithCredentials(email, password)).thenAnswer((_) => Future.value());

      expectLater(loginBloc.state, emitsInOrder(expected))
        .then((_) => verify(mockUserRepository.signInWithCredentials(email, password)).called(1));

      loginBloc.add(event);
    });

    test('with valid credentials, should emit an [LoginState.empty(), LoginState.loading(), LoginState.success()].', () {
      final email = '';
      final password = '';
      final event = LoginWithCredentialsPressed(email: email, password: password);
      final expected = [
        LoginState.empty(),
        LoginState.loading(),
        LoginState.success(),
      ];

      when(mockUserRepository.signInWithCredentials(email, password)).thenAnswer((_) => Future.value());

      expectLater(loginBloc.state, emitsInOrder(expected));

      loginBloc.add(event);
    });

    test('with invalid credentials, should emit an [LoginState.empty(), LoginState.loading(), LoginState.failure()].', () {
      final email = '';
      final password = '';
      final event = LoginWithCredentialsPressed(email: email, password: password);
      final expected = [
        LoginState.empty(),
        LoginState.loading(),
        LoginState.failure(),
      ];

      when(mockUserRepository.signInWithCredentials(email, password)).thenThrow(new Error());

      expectLater(loginBloc.state, emitsInOrder(expected));

      loginBloc.add(event);
    });
  });
}
