import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/infraestructure/inputs/inputs.dart';

final registerFormProvier =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCalback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCalback: registerUserCalback);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String, String) registerUserCalback;

  RegisterFormNotifier({required this.registerUserCalback})
      : super(RegisterFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate(
            [newEmail, state.fullName, state.password, state.passwordTwo]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate(
            [newPassword, state.email, state.fullName, state.passwordTwo]));
  }

  onPasswordTwoChange(String value) {
    final newPasswordTwo = Password.dirty(value);
    state = state.copyWith(
        passwordTwo: newPasswordTwo,
        isValid: Formz.validate(
            [newPasswordTwo, state.password, state.email, state.fullName]));
  }

  onFullNameChange(String value) {
    final newFullName = FullName.dirty(value);
    state = state.copyWith(
        fullName: newFullName,
        isValid: Formz.validate(
            [newFullName, state.email, state.password, state.passwordTwo]));
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid || !arePasswordsEqual()) return;
    await registerUserCalback(state.email.value, state.password.value,
        state.passwordTwo.value, state.fullName.value);
  }

  bool arePasswordsEqual() {
    return state.password.value == state.passwordTwo.value;
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final passwordTwo = Password.dirty(state.passwordTwo.value);
    final fullName = FullName.dirty(state.fullName.value);

    state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        passwordTwo: passwordTwo,
        fullName: fullName,
        isValid: Formz.validate([email, password, fullName, passwordTwo]));
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FullName fullName;
  final Email email;
  final Password password;
  final Password passwordTwo;

  RegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.fullName = const FullName.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.passwordTwo = const Password.pure()});

  RegisterFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          FullName? fullName,
          Email? email,
          Password? password,
          Password? passwordTwo}) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          fullName: fullName ?? this.fullName,
          email: email ?? this.email,
          password: password ?? this.password,
          passwordTwo: passwordTwo ?? this.passwordTwo);
}
