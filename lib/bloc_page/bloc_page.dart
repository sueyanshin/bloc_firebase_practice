import 'package:bloc_test/bloc_page/bloc_event.dart';
import 'package:bloc_test/bloc_page/bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPage extends Bloc<BlocEvent, BlocState> {
  BlocPage() : super(InitialState()) {
    on<LoginEvent>((event, emit) {
      // handle LoginEvent here and emit changes
      emit(LoginState());
    });
    on<SignUpEvent>((event, emit) {
      // handle SignUpEvent here and emit changes
      emit(SignUpState());
    });
    on<HomeEvent>((event, emit) {
      emit(HomeState());
    });
    on<NewPostEvent>((event, emit) {
      emit(NewPostState());
    });
    on<PostListsEvent>((event, emit) {
      emit(PostListsState());
    });
  }

  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is LoginEvent) {
      yield LoginState();
    } else if (event is SignUpEvent) {
      yield SignUpState();
    } else if (event is HomeEvent) {
      yield HomeState();
    } else if (event is NewPostEvent) {
      yield NewPostState();
    } else if (event is PostListsEvent) {
      yield PostListsState();
    }
  }
}
