import 'package:equatable/equatable.dart';

abstract class RedditBlocEvent extends Equatable {
  const RedditBlocEvent();
}

class GetLastPosts extends RedditBlocEvent {
  const GetLastPosts();

  @override
  List<Object> get props => [];
}
