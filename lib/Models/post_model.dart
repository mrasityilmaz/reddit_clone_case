class RedditPostModel {
  Data? data;

  RedditPostModel({this.data});

  RedditPostModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Post>? children;

  Data({this.children});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = <Post>[];
      json['children'].forEach((v) {
        children!.add(Post.fromJson(v['data']));
      });
    }
  }
}

class Post {
  String? selftext;
  String? title;
  int? downs;
  int? thumbnailHeight;
  int? ups;
  int? totalAwardsReceived;
  MediaEmbed? mediaEmbed;
  int? thumbnailWidth;
  SecureMedia? secureMedia;
  SecureMediaEmbed? secureMediaEmbed;
  String? linkFlairText;
  int? score;
  String? thumbnail;
  bool? isSelf;
  String? domain;
  List<AllAwardings>? allAwardings;
  String? linkFlairBackgroundColor;
  String? linkFlairTextColor;
  String? author;
  int? numComments;
  String? url;
  double? created;
  SecureMedia? media;

  Post(
      {this.selftext,
      this.title,
      this.downs,
      this.thumbnailHeight,
      this.ups,
      this.totalAwardsReceived,
      this.mediaEmbed,
      this.thumbnailWidth,
      this.secureMedia,
      this.secureMediaEmbed,
      this.linkFlairText,
      this.score,
      this.thumbnail,
      this.isSelf,
      this.domain,
      this.allAwardings,
      this.linkFlairBackgroundColor,
      this.linkFlairTextColor,
      this.author,
      this.numComments,
      this.url,
      this.created,
      this.media});

  Post.fromJson(Map<String, dynamic> json) {
    selftext = json['selftext'];
    title = json['title'];
    downs = json['downs'];
    thumbnailHeight = json['thumbnail_height'];
    ups = json['ups'];
    totalAwardsReceived = json['total_awards_received'];
    mediaEmbed = json['media_embed'] != null
        ? MediaEmbed.fromJson(json['media_embed'])
        : null;
    thumbnailWidth = json['thumbnail_width'];
    secureMedia = json['secure_media'] != null
        ? SecureMedia.fromJson(json['secure_media'])
        : null;
    secureMediaEmbed = json['secure_media_embed'] != null
        ? SecureMediaEmbed.fromJson(json['secure_media_embed'])
        : null;
    linkFlairText = json['link_flair_text'];
    linkFlairTextColor = json['link_flair_text_color'];
    score = json['score'];
    thumbnail = json['thumbnail'];
    isSelf = json['is_self'];
    domain = json['domain'];
    if (json['all_awardings'] != null) {
      allAwardings = <AllAwardings>[];
      json['all_awardings'].forEach((v) {
        allAwardings!.add(AllAwardings.fromJson(v));
      });
    }
    linkFlairBackgroundColor = json['link_flair_background_color'];
    author = json['author'];
    numComments = json['num_comments'];
    url = json['url'];
    created = json['created_utc'];
    media = json['media'] != null ? SecureMedia.fromJson(json['media']) : null;
  }
}

class MediaEmbed {
  String? content;
  int? width;
  bool? scrolling;
  int? height;

  MediaEmbed({this.content, this.width, this.scrolling, this.height});

  MediaEmbed.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    width = json['width'];
    scrolling = json['scrolling'];
    height = json['height'];
  }
}

class SecureMedia {
  String? type;
  Oembed? oembed;

  SecureMedia({this.type, this.oembed});

  SecureMedia.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    oembed = json['oembed'] != null ? Oembed.fromJson(json['oembed']) : null;
  }
}

class Oembed {
  String? providerUrl;
  String? version;
  String? title;
  String? type;
  int? thumbnailWidth;
  int? height;
  int? width;
  String? html;
  String? authorName;
  String? providerName;
  String? thumbnailUrl;
  int? thumbnailHeight;
  String? authorUrl;

  Oembed(
      {this.providerUrl,
      this.version,
      this.title,
      this.type,
      this.thumbnailWidth,
      this.height,
      this.width,
      this.html,
      this.authorName,
      this.providerName,
      this.thumbnailUrl,
      this.thumbnailHeight,
      this.authorUrl});

  Oembed.fromJson(Map<String, dynamic> json) {
    providerUrl = json['provider_url'];
    version = json['version'];
    title = json['title'];
    type = json['type'];
    thumbnailWidth = json['thumbnail_width'];
    height = json['height'];
    width = json['width'];
    html = json['html'];
    authorName = json['author_name'];
    providerName = json['provider_name'];
    thumbnailUrl = json['thumbnail_url'];
    thumbnailHeight = json['thumbnail_height'];
    authorUrl = json['author_url'];
  }
}

class SecureMediaEmbed {
  String? content;
  int? width;
  bool? scrolling;
  String? mediaDomainUrl;
  int? height;

  SecureMediaEmbed(
      {this.content,
      this.width,
      this.scrolling,
      this.mediaDomainUrl,
      this.height});

  SecureMediaEmbed.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    width = json['width'];
    scrolling = json['scrolling'];
    mediaDomainUrl = json['media_domain_url'];
    height = json['height'];
  }
}

class AllAwardings {
  String? iconUrl;
  List<ResizedIcons>? resizedIcons;
  List<ResizedIcons>? resizedStaticIcons;
  String? staticIconUrl;

  AllAwardings(
      {this.iconUrl,
      this.resizedIcons,
      this.resizedStaticIcons,
      this.staticIconUrl});

  AllAwardings.fromJson(Map<String, dynamic> json) {
    iconUrl = json['icon_url'];
    if (json['resized_icons'] != null) {
      resizedIcons = <ResizedIcons>[];
      json['resized_icons'].forEach((v) {
        resizedIcons!.add(ResizedIcons.fromJson(v));
      });
    }
    if (json['resized_static_icons'] != null) {
      resizedStaticIcons = <ResizedIcons>[];
      json['resized_static_icons'].forEach((v) {
        resizedStaticIcons!.add(ResizedIcons.fromJson(v));
      });
    }
    staticIconUrl = json['static_icon_url'];
  }
}

class ResizedIcons {
  String? url;
  int? width;
  int? height;

  ResizedIcons({this.url, this.width, this.height});

  ResizedIcons.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }
}
