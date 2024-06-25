// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/featuers/coaches-gyms/screens/gym/gym_locations_screen.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/gym_model.dart';

class SearchGymDelegate extends SearchDelegate {
  final WidgetRef ref;
  final String collection;
  final Size size;

  SearchGymDelegate(
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
    List<GymModel> fliterList;
    return ref.watch(getGymsProvider).when(
          data: (gyms) {
            fliterList = gyms
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
                      final gym = fliterList[index];
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(gym.image),
                          ),
                          title: Text('r/${gym.name}'),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            // Future.delayed(Duration(milliseconds: 30));
                            Get.to(GymLocationsScreen(
                              collection: collection,
                              gymModel: gym,
                              fromAsk: false,
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
//  return ref.watch(getSearchGymsProvider(query)).when(
//           data: (gyms) => ListView.builder(
//             itemCount: gyms.length,
//             itemBuilder: (BuildContext context, int index) {
//               print("hello");
//               final gym = gyms[index];
//               return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(gym.image),
//                   ),
//                   title: Text('r/${gym.name}'),
//                   onTap: () async {
//                     FocusScope.of(context).unfocus();
//                     // Future.delayed(Duration(milliseconds: 30));
//                     Get.to(GymLocationsScreen(
                      // collection: collection,
                      // gymModel: gym,
                      // fromAsk: false,
//                     ));
//                   });
//             },
//           ),
//           error: (error, stackTrace) => ErrorText(
//             error: error.toString(),
//           ),
//           loading: () => const Loader(),
//         );