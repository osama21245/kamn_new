// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/featuers/coaches-gyms/screens/coach/coaches_details_screen.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';

class SearchCoachDelegate extends SearchDelegate {
  final WidgetRef ref;
  final String collection;
  final Size size;

  SearchCoachDelegate(
    this.ref,
    this.collection,
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
    return ref.watch(getSearchCoachesProvider(query)).when(
          data: (coaches) => ListView.builder(
            itemCount: coaches.length,
            itemBuilder: (BuildContext context, int index) {
              print("hello");
              final coach = coaches[index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(coach.image),
                  ),
                  title: Text('r/${coach.name}'),
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    // Future.delayed(Duration(milliseconds: 30));
                    Get.to(CoachesDetailsScreen(
                      fromAsk: false,
                      collection: collection,
                      coacheModel: coach,
                    ));
                  });
            },
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
    //     List<CoacheModel> fliterList;
    // return ref.watch(getCoachesProvider).when(
    //       data: (coaches) {
    //         fliterList = coaches
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
    //                   final coach = fliterList[index];
    //                   return ListTile(
    //                       leading: CircleAvatar(
    //                         backgroundImage: CachedNetworkImageProvider(coach.image),
    //                       ),
    //                       title: Text('r/${coach.name}'),
    //                       onTap: () async {
    //                         FocusScope.of(context).unfocus();
    //                         // Future.delayed(Duration(milliseconds: 30));
    //                          Get.to(CoachesDetailsScreen(
    //                   collection: collection,
    //                   coacheModel: coach,
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
