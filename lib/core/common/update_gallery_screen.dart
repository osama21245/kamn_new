import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/common/custom_update_gallery_uppersec.dart';
import 'package:kman/core/constants/collection_constants.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/coaches-gyms/controller/coaches-gyms_controller.dart';
import '../providers/storage_repository.dart';
import '../providers/utils.dart';
import '../../theme/pallete.dart';

class UpdateGalleryScreen extends ConsumerStatefulWidget {
  final List<dynamic> gallery;
  final String collection;
  final String storeId;
  final String gymlLocatyionId;
  const UpdateGalleryScreen(
      {super.key,
      required this.gallery,
      required this.collection,
      required this.storeId,
      required this.gymlLocatyionId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateGalleryScreenState();
}

class _UpdateGalleryScreenState extends ConsumerState<UpdateGalleryScreen> {
  bool makeChange = false;
  int lastIteration = 0;

  @override
  Widget build(BuildContext context) {
    List<File> addGallery = [];

    pickimagesfromGallery(BuildContext context) async {
      final res = await picImage();

      if (res != null) {
        addGallery.add(File(res.files.first.path!));
      }
      makeChange = true;
      setState(() {});
    }

    deleteImage(String path, int iteration) {
      ref.watch(storageRepositoryProvider).deleteFile(
            path: path,
          );
      widget.gallery.removeAt(iteration);
      makeChange = true;
      setState(() {});
    }

    void updateGallery() {
      if (widget.collection == Collections.coachCollection ||
          widget.collection == Collections.gymCollection) {
        ref.watch(coachesGymsControllerProvider.notifier).updateGallery(
            widget.storeId,
            widget.collection,
            widget.gallery,
            addGallery,
            lastIteration,
            widget.gymlLocatyionId,
            context);
      } else {
        ref.watch(benefitsControllerProvider.notifier).updateGallery(
            widget.collection, widget.storeId, widget.gallery, context);
      }
      print("=============================");
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomUpdateGalleryUpperSec(
              size: size,
              color: Pallete.fontColor,
              title: "Update Gallery",
              ontap: !makeChange
                  ? () => Navigator.of(context).pop()
                  : () => updateGallery()),
          SizedBox(
            height: size.width * 0.02,
          ),
          widget.gallery.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                      height: size.height * 0.3,
                      width: size.width,
                      child: GridView.builder(
                          itemCount: widget.gallery.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.54, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            addGallery.map((e) => Stack(
                                  children: [
                                    Image.file(
                                      addGallery[index],
                                    ),
                                    InkWell(
                                        onTap: () {
                                          addGallery.removeAt(index);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(
                                              90, 255, 255, 255),
                                          child: Icon(
                                            Icons.delete,
                                            color: Pallete.redColor,
                                          ),
                                        )),
                                  ],
                                ));
                            return Stack(
                              children: [
                                Image.network(
                                  widget.gallery[index],
                                ),
                                InkWell(
                                    onTap: () {
                                      deleteImage(widget.gallery[index], index);
                                      lastIteration = widget.gallery.length;
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                          90, 255, 255, 255),
                                      child: Icon(
                                        Icons.delete,
                                        color: Pallete.redColor,
                                      ),
                                    )),
                              ],
                            );
                          }),
                    ),
                  ),
                )
              : Center(
                  child: Container(
                      height: size.height * 0.2,
                      width: size.width,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Pallete.greyColor, width: 2),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02)),
                      child: Center(
                          child: Text(
                        "Enter Cv Images",
                        style: TextStyle(
                            color: Pallete.greyColor,
                            fontFamily: "Muller",
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w600),
                      ))),
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: ElevatedButton(
              onPressed: () {
                pickimagesfromGallery(context);
                lastIteration = widget.gallery.length;
              },
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  fixedSize: Size(size.width, size.height * 0.06),
                  backgroundColor: Pallete.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.02))),
              child: Text(
                'Update Gallery images',
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontFamily: "Muller",
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
