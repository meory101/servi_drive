import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUsecase registerUsecase;

  AuthBloc({required this.registerUsecase}) : super(AuthInitial()) {
    on<RegisterEvent>(_onRegisterEvent);
  }

  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await registerUsecase(entity: event.entity);

    result.fold(
      (failure) => emit(AuthFailure(failure: failure)),
      (response) => emit(AuthSuccess(response: response)),
    );
  }
} 