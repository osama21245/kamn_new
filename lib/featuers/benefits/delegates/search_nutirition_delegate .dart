// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/class/searchParameters.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/benefits/screens/nutrition/nutrition_details_screen.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import 'package:kman/featuers/coaches-gyms/screens/gym/gym_details_screen.dart';
import 'package:kman/models/nutrition_model.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';

class SearchNutiritionDelegate extends SearchDelegate {
  final WidgetRef ref;
  final String collection;
  final Size size;

  SearchNutiritionDelegate(
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
    return ref.watch(getSearchNutiritions(query)).when(
          data: (nutiritions) => ListView.builder(
            itemCount: nutiritions.length,
            itemBuilder: (BuildContext context, int index) {
              print("hello");
              final nutirition = nutiritions[index];
              return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(nutirition.image),
                  ),
                  title: Text('r/${nutirition.name}'),
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    // Future.delayed(Duration(milliseconds: 30));
                    Get.to(NutritionDetailsScreen(
                      fromAsk: false,
                      collection: collection,
                      nutritionModel: nutirition,
                    ));
                  });
            },
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
    //   List<NutritionModel> fliterList;
    // return ref.watch(getNutritionProvider).when(
    //       data: (nutritions) {
    //         fliterList = nutritions
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
    //                   final nutrition = fliterList[index];
    //                   return ListTile(
    //                       leading: CircleAvatar(
    //                         backgroundImage: CachedNetworkImageProvider(nutrition.image),
    //                       ),
    //                       title: Text('r/${nutrition.name}'),
    //                       onTap: () async {
    //                         FocusScope.of(context).unfocus();
    //                         // Future.delayed(Duration(milliseconds: 30));
    //                         Get.to(NutritionDetailsScreen(
    //                           collection: collection,
    //                           nutritionModel: nutrition,
    //                         ));
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
