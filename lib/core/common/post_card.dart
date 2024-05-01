import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/models/post_model_motivation.dart';
import '../../featuers/auth/controller/auth_controller.dart';
import '../../featuers/post/controller/post_controller.dart';
import 'package:share_plus/share_plus.dart';
import '../../theme/pallete.dart';
import '../constants/constants.dart';
import 'package:http/http.dart' as https;

class PostCard extends ConsumerWidget {
  final PostMotivation post;
  const PostCard({
    super.key,
    required this.post,
  });

  void upVotes(WidgetRef ref) {
    ref.read(postControllerProvider.notifier).upvote(post);
  }

  void deletePost(WidgetRef ref, BuildContext context) {
    ref.read(postControllerProvider.notifier).deletePost(post, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeImage = post.type == 'image';
    final isTypeText = post.type == 'text';
    final isTypeLink = post.type == 'link';
    final user = ref.watch(usersProvider)!;
    Size size = MediaQuery.of(context).size;

    void sharePost() async {
      if (isTypeText) {
        Share.share("${post.title}\n${post.description}");
      } else if (isTypeImage) {
        final url = Uri.parse(post.link!);
        final response = await https.get(url);
        Share.shareXFiles([XFile.fromData(response.bodyBytes, name: "Kamn")],
            subject: "Kamn Posts");
      } else {
        Share.share("${post.title}\n${post.link}");
      }
    }

    return Padding(
      padding: EdgeInsets.all(size.width * 0.03),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(75, 42, 41, 43)),
              borderRadius: BorderRadius.circular(size.width * 0.02),
              color: Color.fromARGB(8, 134, 85, 212),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (kIsWeb)
                  Column(
                    children: [
                      IconButton(
                        onPressed: () => upVotes(ref),
                        icon: Icon(
                          Constants.up,
                          size: 30,
                          color: post.upvotes.contains(user.uid)
                              ? Pallete.redColor
                              : null,
                        ),
                      ),
                      Text(
                        '${post.upvotes.length - post.downvotes.length == 0 ? 'Love' : post.upvotes.length - post.downvotes.length}',
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ).copyWith(right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                        "assets/page-1/images/kamn_new.jpg",
                                      ),
                                      radius: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Kamn company',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Text(
                                              'u/${user.name}',
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    if (post.uid == user.uid)
                                      IconButton(
                                        onPressed: () =>
                                            deletePost(ref, context),
                                        icon: Icon(
                                          Icons.delete,
                                          color: Pallete.redColor,
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                            if (post.awards.isNotEmpty) ...[
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: post.awards.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final award = post.awards[index];
                                    return Image.asset(
                                      Constants.awards[award]!,
                                      height: 23,
                                    );
                                  },
                                ),
                              ),
                            ],
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 5),
                              child: Text(
                                post.title,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (isTypeImage)
                              Padding(
                                padding:
                                    EdgeInsets.only(right: size.width * 0.03),
                                child: SizedBox(
                                  width: size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: CachedNetworkImage(
                                    imageUrl: post.link!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            if (isTypeLink)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 19),
                                child: AnyLinkPreview(
                                  displayDirection:
                                      UIDirection.uiDirectionHorizontal,
                                  link: post.link!,
                                ),
                              ),
                            if (isTypeText)
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text(
                                  post.description!,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (!kIsWeb)
                                    Row(
                                      children: [
                                        post.upvotes.contains(user.uid)
                                            ? IconButton(
                                                onPressed: () => upVotes(ref),
                                                icon: Icon(Icons.favorite,
                                                    size: 30,
                                                    color: Pallete.redColor),
                                              )
                                            : IconButton(
                                                onPressed: () => upVotes(ref),
                                                icon: Icon(
                                                  Icons.heart_broken_outlined,
                                                  size: 30,
                                                  color: null,
                                                ),
                                              ),
                                        Text(
                                          '${post.upvotes.length - post.downvotes.length == 0 ? 'Love' : post.upvotes.length - post.downvotes.length}',
                                          style: const TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  InkWell(
                                    onTap: sharePost,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.06),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: sharePost,
                                            icon: const Icon(
                                              Icons.share,
                                            ),
                                          ),
                                          Text(
                                            'Share',
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
