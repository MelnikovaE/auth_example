import 'package:auth_example/data/repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  final ApiRepository _apiRepository;
  AuthorizationBloc(this._apiRepository) : super(AuthorizationInitialState()) {
    //Отправка почты
    on<SendEmailEvent>((event, emit) async {
      emit(SendingEmailState());
      try{
        await _apiRepository.sendVerificationCode({"email": event.email});
        emit(SuccessSendingEmailState());
      }
      catch(e){
        emit(ErrorSendingEmailState());
      }
    });
  }

  //Отправка кода 
  
}
