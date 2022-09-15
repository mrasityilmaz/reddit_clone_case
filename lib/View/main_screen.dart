import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Models/post_model.dart';
import '../RedditBloc/reddit_bloc.dart';
import '../RedditBloc/reddit_bloc_state.dart';
import '../RedditBloc/reddit_event.dart';
import '../Utils/Constants/ui_constants.dart';
import 'package:html/parser.dart';
import '../Utils/Extensions/extensions.dart';
import '../Utils/Functions/time_formatter.dart';
import 'Widgets/dot_widget.dart';
import 'Widgets/error_widget.dart';
import 'Widgets/my_progressbar.dart';

class RedditMainScreen extends StatelessWidget {
  const RedditMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final redditBloc = BlocProvider.of<RedditBloc>(context);
    return Scaffold(
      backgroundColor: redditBgColor,
      body: SizedBox(
        child: BlocBuilder<RedditBloc, RedditBlocState>(
          bloc: redditBloc..add(const GetLastPosts()),
          builder: (context, state) {
            if (state is LoadingState) {
              return const MyCircularProgressBar();
            }

            if (state is SuccessState) {
              return SafeArea(
                top: true,
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                        child: MainBodyWidget(
                      posts: (state.response.response as RedditPostModel)
                              .data
                              ?.children ??
                          [],
                    )),
                  ],
                ),
              );
            } else {
              state as FailureState;
              return Center(
                  child: MyErrorWidget(
                errorMessage: state.failure.errorMessage.toString(),
              ));
            }
          },
        ),
      ),
    );
  }
}

class MainBodyWidget extends StatelessWidget {
  final List<Post> posts;
  const MainBodyWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostWidget(post: posts[index]);
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            "u/${post.author!}".replaceAll('', '\u200B'),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black54),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (post.created != null)
                          Row(
                            children: [
                              const DotWidget(),
                              Text(readTimestamp(post.created!.toInt()),
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black54)),
                            ],
                          ),
                        if (post.isSelf != null &&
                            post.isSelf == false &&
                            post.domain != null)
                          Row(
                            children: [
                              const DotWidget(),
                              Text(post.domain!,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.black54)),
                            ],
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Icon(
                        Icons.more_horiz_rounded,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.totalAwardsReceived != null &&
                    post.totalAwardsReceived! > 0 &&
                    post.allAwardings != null &&
                    post.allAwardings!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0) +
                        const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Row(
                            children: post.allAwardings!.reversed
                                .toList()
                                .map((e) => Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: Image.network(
                                        e.resizedStaticIcons![0].url!
                                            .replaceAll(
                                                "https://preview", "https://i"),
                                        height: e.resizedStaticIcons![0].height!
                                            .toDouble(),
                                        width: e.resizedStaticIcons![0].width!
                                            .toDouble(),
                                      ),
                                    ))
                                .toList()),
                        Text(
                          "${post.totalAwardsReceived} Awards",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                if ((post.title != null &&
                        post.secureMedia != null &&
                        post.secureMedia!.oembed != null &&
                        post.secureMedia!.oembed!.type != null &&
                        post.secureMedia!.oembed!.type != "video") ||
                    (post.title != null &&
                            post.thumbnail != null &&
                            post.thumbnail!.split('.')[0] != "self") &&
                        post.secureMedia?.oembed == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0) +
                        const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            post.title!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: LayoutBuilder(
                              builder: (p0, p1) => Container(
                                height: (p1.maxWidth / 16) * 9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(width: 0.2),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        post.secureMedia?.oembed
                                                ?.thumbnailUrl ??
                                            post.thumbnail!,
                                      )),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(3)),
                                        color: Colors.black.withOpacity(.7),
                                      ),
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 4),
                                      child: Text(
                                        post.domain ?? "",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      )),
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0) +
                        const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      post.title!,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                if (post.linkFlairText != null &&
                    post.linkFlairText!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0) +
                        const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              HexColor.fromHex(post.linkFlairBackgroundColor!)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 8),
                      child: Text(
                        post.linkFlairText!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 11,
                            color: post.linkFlairTextColor != null &&
                                    post.linkFlairTextColor == "light"
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                if (post.secureMedia != null &&
                    post.secureMedia!.oembed != null &&
                    post.secureMedia!.oembed!.type != null &&
                    post.secureMedia!.oembed!.type == "video")
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.network(
                        post.secureMedia!.oembed!.thumbnailUrl!,
                        fit: BoxFit.fitWidth,
                      )),
                if (post.selftext != null && post.selftext!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8) +
                        const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      parse(parse(post.selftext!
                                  .replaceAll(RegExp(r"(?! )\s+| \s+"), " "))
                              .body!
                              .text)
                          .documentElement!
                          .text,
                      textAlign: TextAlign.left,
                      maxLines: 4,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/up_arrow.svg",
                            width: 14,
                            height: 18,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: post.score != null && post.ups != null
                                  ? Text(
                                      post.score!.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text(
                                      "Vote",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600),
                                    )),
                          SvgPicture.asset(
                            "assets/icons/down_arrow.svg",
                            width: 14,
                            height: 18,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/msg_bubble.svg",
                            width: 14,
                            height: 18,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: post.numComments != null &&
                                      post.numComments! > 0
                                  ? Text(
                                      post.numComments!.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text(
                                      "Comments",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600),
                                    )),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            size: 28,
                            color: const Color(0xFF89898C).withOpacity(.5),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Text(
                              "Share",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
