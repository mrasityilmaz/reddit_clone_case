String redditGetMainItems =
    "https://www.reddit.com/r/flutterdev/top.json?count=20";

String redditGetMainItemDetails(String username) =>
    "https://www.reddit.com/user/$username/about.json";
