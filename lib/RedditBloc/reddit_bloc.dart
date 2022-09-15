import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit_clone_case/RedditBloc/reddit_event.dart';

import '../../Utils/ApiStatus/api_status.dart';
import '../Repository/reddit_repository.dart';
import 'reddit_bloc_state.dart';

class RedditBloc extends Bloc<RedditBlocEvent, RedditBlocState> {
  final RedditRepository serviceRepository;

  RedditBloc({
    required this.serviceRepository,
  })  
  // ignore: unnecessary_null_comparison
  : assert(serviceRepository != null),
        super(LoadingState()) {
    on<RedditBlocEvent>((event, emit) async {
      if (event is GetLastPosts) {
        await _getLastPost(emit);
      }
    });
  }

  Future _getLastPost(
    Emitter<RedditBlocState> emit,
  ) async {
    emit(LoadingState());
    try {
      final response = await serviceRepository.getLastPost();
      if (response is Success) {
        emit(SuccessState(response));
      } else if (response is Failure) {
        emit(FailureState(response));
      }
    } catch (_) {
      emit(FailureState(Failure(errorMessage: _)));
    }
  }
}
