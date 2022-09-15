import '../DataProvider/reddit_data_provider.dart';

class RedditRepository {
  final RedditDataProvider dataProvider;
  RedditRepository(this.dataProvider);

  Future<Object> getLastPost() async {
    return await dataProvider.getMainItems();
  }
}
