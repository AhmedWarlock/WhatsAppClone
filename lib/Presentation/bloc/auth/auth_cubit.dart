import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:whatsapp_clone/domain/usecases/user_cases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsLoggedInUserCase isLoggedInUserCase;
  final GetCurrentUIDUserCase getCurrentUIDUserCase;
  final SignOutUserCase signOutUserCase;
  AuthCubit(
    this.isLoggedInUserCase,
    this.getCurrentUIDUserCase,
    this.signOutUserCase,
  ) : super(AuthInitial());

  Future<void> appStartUp() async {
    try {
      bool isLoggedIn = await isLoggedInUserCase.call();
      if (isLoggedIn) {
        final uID = await getCurrentUIDUserCase.call();
        emit(AuthenticatedState(uID: uID));
      } else {
        emit(UnAuthenticatedState());
      }
    } catch (_) {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> loggedIn() async {
    try {
      String uid = await getCurrentUIDUserCase.call();
      emit(AuthenticatedState(uID: uid));
    } catch (_) {
      print('Couldnt tell if LOGGEDIN');
    }
  }

  Future<void> logOut() async {
    try {
      await signOutUserCase.call();
      emit(UnAuthenticatedState());
    } catch (_) {}
  }
}
