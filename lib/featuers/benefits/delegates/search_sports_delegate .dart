// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/constants/services/collection_constants.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/benefits/screens/sports/sports_details_screen.dart';
import 'package:kman/models/sports_model.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';

class SearchSportsDelegate extends SearchDelegate {
  final WidgetRef ref;
  final Size size;

  SearchSportsDelegate(
    this.ref,
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
    return ref.watch(getSearchSports(query)).when(
          data: (Sports) => ListView.builder(
            itemCount: Sports.length,
            itemBuilder: (BuildContext context, int index) {
              print("hello");
              final sport = Sports[index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(sport.image),
                  ),
                  title: Text('r/${sport.name}'),
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    // Future.delayed(Duration(milliseconds: 30));
                    Get.to(SportsDetailsScreen(
                      fromAsk: false,
                      collection: Collections.sportsCollection,
                      sportsModel: sport,
                    ));
                  });
            },
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
    //     List<SportsModel> fliterList;
    // return ref.watch(getSportsProvider).when(
    //       data: (sports) {
    //         fliterList = sports
    //             .where(
    //                 (element) => element.name.toLowerCase().startsWith(query))
    //             .toList();
    //         return query == ""
    //             ? Center(
    //                 child: Text(""),
    //               )
    //             : ListView.builder(
    //                 itemCount: fliterList.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   print("hello");
    //                   final sport = fliterList[index];
    //                   return ListTile(
    //                       leading: CircleAvatar(
    //                         backgroundImage: CachedNetworkImageProvider(sport.image),
    //                       ),
    //                       title: Text('r/${sport.name}'),
    //                       onTap: () async {
    //                         FocusScope.of(context).unfocus();
    //                         // Future.delayed(Duration(milliseconds: 30));
    //                         Get.to(SportsDetailsScreen(
    //                   collection: Collections.sportsCollection,
    //                   sportsModel: sport,
    //                 ));
    //                       });
    //                 },
    //               );
    //       },
    //       error: (error, stackTrace) => ErrorText(
    //         error: error.toString(),
    //       ),
    //       loading: () => const Loader(),
    //     );
  }
}
