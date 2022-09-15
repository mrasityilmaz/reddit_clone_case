import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import 'DataProvider/reddit_data_provider.dart';
import 'RedditBloc/reddit_bloc.dart';
import 'Repository/reddit_repository.dart';
import 'View/main_screen.dart';

void main() {
  RedditDataProvider redditDataProvider =
      RedditDataProvider(httpClient: http.Client());

  RedditRepository redditRepository = RedditRepository(redditDataProvider);

  runApp(
    BlocProvider<RedditBloc>(
        create: (context) => RedditBloc(serviceRepository: redditRepository),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: RedditMainScreen());
  }
}
