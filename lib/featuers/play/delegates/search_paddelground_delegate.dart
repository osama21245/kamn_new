// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/class/searchParameters.dart';
import 'package:kman/featuers/play/controller/play_controller.dart';
import 'package:kman/featuers/play/screens/ground_details_screen.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/grounds_model.dart';

class SearchPaddelGroundDelegate extends SearchDelegate {
  final WidgetRef ref;
  final String collection;
  final Color color;
  final List<Color> backGorundColor;
  final Size size;

  SearchPaddelGroundDelegate(
    this.ref,
    this.collection,
    this.color,
    this.backGorundColor,
    this.size,
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<GroundModel> fliterList;
    return ref.watch(getPaddelGrounds).when(
          data: (grounds) {
            fliterList = grounds
                .where(
                    (element) => element.name.toLowerCase().startsWith(query))
                .toList();
            return query == ""
                ? Center(
                    child: Text(""),
                  )
                : ListView.builder(
                    itemCount: fliterList.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("hello");
                      final ground = fliterList[index];
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(ground.image),
                          ),
                          title: Text('r/${ground.name}'),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            // Future.delayed(Duration(milliseconds: 30));
                            Get.to(GroundDetailsScreen(
                              fromAsk: false,
                              color: color,
                              size: size,
                              backgroundColor: backGorundColor,
                              collection: collection,
                              groundModel: ground,
                            ));
                          });
                    },
                  );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
    // return ref.watch(getSearchPaddelGrounds(query)).when(
    //       data: (grounds) => ListView.builder(
    //         itemCount: grounds.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           print("hello");
    //           final ground = grounds[index];
    //           return ListTile(
    //               leading: CircleAvatar(
    //                 backgroundImage: CachedNetworkImageProvider(ground.image),
    //               ),
    //               title: Text('r/${ground.name}'),
    //               onTap: () async {
    //                 FocusScope.of(context).unfocus();
    //                 // Future.delayed(Duration(milliseconds: 30));
    //                 Get.to(GroundDetailsScreen(
    //                   fromAsk: false,
    //                   color: color,
    //                   size: size,
    //                   backgroundColor: backGorundColor,
    //                   collection: collection,
    //                   groundModel: ground,
    //                 ));
    //               });
    //         },
    //       ),
    //       error: (error, stackTrace) => ErrorText(
    //         error: error.toString(),
    //       ),
    //       loading: () => const Loader(),
    //     );