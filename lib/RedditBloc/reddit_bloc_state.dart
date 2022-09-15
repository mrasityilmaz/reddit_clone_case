import 'package:equatable/equatable.dart';

import '../../Utils/ApiStatus/api_status.dart';

class RedditBlocState extends Equatable {
  const RedditBlocState();

  @override
  List<Object> get props => [];
}

class LoadingState extends RedditBlocState {}

class SuccessState extends RedditBlocState {
  final Success response;

  const SuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class FailureState extends RedditBlocState {
  final Failure failure;

  const FailureState(this.failure);

  @override
  List<Object> get props => [failure];
}
