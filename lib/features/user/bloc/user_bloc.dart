import 'package:alumni_hub_ft_uh/features/auth/domain/auth_model.dart';
import 'package:alumni_hub_ft_uh/features/auth/domain/auth_repository.dart';
import 'package:alumni_hub_ft_uh/features/user/domain/user_model.dart';
import 'package:alumni_hub_ft_uh/features/user/domain/user_repository.dart';
import 'package:alumni_hub_ft_uh/middleware/custom_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  UserBloc(this._userRepository, this._authRepository) : super(UserInitial()) {
    on<UserEventSignIn>((event, emit) async {
      emit(UserStateSignInLoading());
      try {
        final response = await _authRepository.signIn(event.signInBody);
        _userRepository.saveUserSession(
            UserSession(token: response.token, user: response.user));
        emit(UserStateSuccessSignIn(response));
      } on CustomException catch (e) {
        emit(UserStateException(e));
      }
    });

    on<UserEventSignUp>((event, emit) async {
      emit(UserStateSignUpLoading());
      try {
        final response = await _authRepository.signUp(event.signUpBody);
        _userRepository.saveUserSession(
            UserSession(token: response.token, user: response.user));
        emit(UserStateSuccessSignUp(response));
      } on CustomException catch (e) {
        emit(UserStateException(e));
      }
    });

    on<UserEventGetProfile>((event, emit) async {
      emit(UserStateGetProfileLoading());
      try {
        final user = await _userRepository.getProfile();
        await Future.delayed(const Duration(seconds: 3));
        emit(UserStateSuccessGetProfile(user));
      } on CustomException catch (e) {
        emit(UserStateException(e));
      }
    });
  }

  UserSession? getUserSession() => _userRepository.getUserSession();

  Future<void> signOut() async {
    await _authRepository.signOut();
    await clearUserSession();
  }

  Future<bool> clearUserSession() => _userRepository.deleteUserSession();
}
