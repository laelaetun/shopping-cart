import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/application/auth/auth_event.dart';
import 'package:shopping_cart/application/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_cart/application/service/auth/firebase_auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final user = authService.currentUser;
      if (user != null) {
        emit(
          Authenticated(
            uid: user.uid,
            email: user.email,
            displayName: user.displayName,
          ),
        );
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final credential = await authService.signIn(
          email: event.email,
          password: event.password,
        );
        final user = credential.user;
        if (user != null) {
          emit(
            Authenticated(
              uid: user.uid,
              email: user.email,
              displayName: user.displayName,
            ),
          );
        } else {
          emit(AuthError('Login failed. Please try again.'));
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthError(authService.mapAuthError(e)));
      } catch (_) {
        emit(AuthError('Login failed. Please try again.'));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final credential = await authService.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        final user = credential.user;
        if (user != null) {
          emit(
            Authenticated(
              uid: user.uid,
              email: user.email,
              displayName: user.displayName,
            ),
          );
        } else {
          emit(AuthError('Registration failed. Please try again.'));
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthError(authService.mapAuthError(e)));
      } catch (_) {
        emit(AuthError('Registration failed. Please try again.'));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authService.signOut();
      emit(Unauthenticated());
    });
  }
}
