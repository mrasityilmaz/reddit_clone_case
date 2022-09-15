String readTimestamp(int timestamp) {
  var now = DateTime.now().toUtc();

  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  var diff = now.difference(date);
  var time = '';

  if (diff.inHours > 0 && diff.inHours < 24) {
    time = '${diff.inHours}h';
  } else if (diff.inMinutes > 0 && diff.inMinutes < 60) {
    time = '${diff.inMinutes}m';
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = '${diff.inDays}d';
  } else {
    time = '${(diff.inDays / 7).floor()}w';
  }

  return time;
}
