import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/user/controller/user_controller.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../../theme/pallete.dart';

class InBoxScreen extends ConsumerWidget {
  const InBoxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(usersProvider);
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 29.0),
            child: CustomUpperSec(
                size: size, color: Pallete.fontColor, title: "InBox")),
        SizedBox(
          height: size.height * 0.032,
        ),
        ref.watch(getInBoxMessagesProviderr(user!.uid)).when(
            data: (inBox) => ListView.builder(
                itemCount: inBox.length,
                itemBuilder: (context, i) {
                  final inboxMessage = inBox[i];
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0),
                      child: Stack(
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              trailing: const Icon(Icons.mail),
                              title: Text(
                                inboxMessage.title,
                                style: const TextStyle(
                                    color: Pallete.fontColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(inboxMessage.description),
                            ),
                          ),
                          Positioned(
                              right: 65,
                              top: 11,
                              child: Image.asset(
                                "assets/page-1/images/kamn_sentence.png",
                                width: size.width * 0.3,
                              ))
                        ],
                      ));
                }),
            error: (error, StackTrace) {
              print(error);

              return ErrorText(error: error.toString());
            },
            loading: () => LottieBuilder.asset(
                  fit: BoxFit.contain,
                  AppImageAsset.loading,
                  repeat: true,
                ))
      ],
    );
  }
}
