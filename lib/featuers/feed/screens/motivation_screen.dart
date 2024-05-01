import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/post_card.dart';
import '../../post/controller/post_controller.dart';

class MotivationScreen extends ConsumerWidget {
  const MotivationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ref.watch(getPostsProvider).when(
          skipLoadingOnRefresh: true,
          data: (posts) {
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(
                    post: post,
                  );
                });
          },
          error: (error, StackTrace) {
            print(error);
            ;
            return ErrorText(error: error.toString());
          },
          loading: () => const Loader()),
    );
  }
}
