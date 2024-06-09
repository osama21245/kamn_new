// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/benefits/screens/medical/medical_details_screen.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/medical_model.dart';

class SearchMedicalDelegate extends SearchDelegate {
  final WidgetRef ref;
  final String collection;
  final Size size;

  SearchMedicalDelegate(
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
    List<MedicalModel> fliterList;
    return ref.watch(getMedicalProvider).when(
          data: (medicals) {
            fliterList = medicals
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
                      final medical = fliterList[index];
                      return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(medical.image),
                          ),
                          title: Text('r/${medical.name}'),
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            // Future.delayed(Duration(milliseconds: 30));
                            Get.to(MedicalDetailsScreen(
                              fromAsk: false,
                              collection: collection,
                              medicalModel: medical,
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
  // return ref.watch(getSearchMedical(query)).when(
  //         data: (medicals) => ListView.builder(
  //           itemCount: medicals.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             print("hello");
  //             final medical = medicals[index];
  //             return ListTile(
  //                 leading: CircleAvatar(
  //                   backgroundImage: NetworkImage(medical.image),
  //                 ),
  //                 title: Text('r/${medical.name}'),
  //                 onTap: () async {
  //                   FocusScope.of(context).unfocus();
  //                   // Future.delayed(Duration(milliseconds: 30));
  //                   Get.to(MedicalDetailsScreen(
                      // fromAsk: false,
                      // collection: collection,
                      // medicalModel: medical,
  //                   ));
  //                 });
  //           },
  //         ),
  //         error: (error, stackTrace) => ErrorText(
  //           error: error.toString(),
  //         ),
  //         loading: () => const Loader(),
  //       );