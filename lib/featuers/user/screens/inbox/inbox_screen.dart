import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/core/function/goTo.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/user/controller/user_controller.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common/custom_uppersec.dart';
import '../../../../core/common/error_text.dart';
import '../../../../core/constants/imgaeasset.dart';
import '../../../../theme/pallete.dart';
import 'inbox_details_screen.dart';

class InBoxScreen extends ConsumerWidget {
  const InBoxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(usersProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: CustomUpperSec(
                    size: size, color: Pallete.fontColor, title: "InBox")),
            SizedBox(
              height: size.height * 0.012,
            ),
            Expanded(
              child: ref.watch(getInBoxMessagesProviderr(user!.uid)).when(
                  data: (inBox) => inBox.isEmpty
                      ? LottieBuilder.asset(
                          fit: BoxFit.contain,
                          AppImageAsset.nodata,
                          repeat: true,
                        )
                      : ListView.builder(
                          itemCount: inBox.length,
                          itemBuilder: (context, i) {
                            final inboxMessage = inBox[i];
                            return InkWell(
                              onTap: () => goToScreen(
                                  context,
                                  InBoxDetailsScreen(
                                    inBoxModel: inboxMessage,
                                  )),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0),
                                  child: Stack(
                                    children: [
                                      Card(
                                        color:
                                            Color.fromARGB(143, 255, 255, 255),
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                          trailing: Image.asset(
                                            "assets/page-1/images/kamn_sentence.png",
                                            width: size.width * 0.15,
                                          ),
                                          title: Text(
                                            inboxMessage.title,
                                            style: const TextStyle(
                                                color: Pallete.fontColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle:
                                              Text(inboxMessage.description),
                                        ),
                                      ),
                                      // Positioned(
                                      //     right: 65,
                                      //     top: 11,
                                      //     child: Image.asset(
                                      //       "assets/page-1/images/kamn_sentence.png",
                                      //       width: size.width * 0.1,
                                      //     ))
                                    ],
                                  )),
                            );
                          }),
                  error: (error, StackTrace) {
                    print(error);

                    return ErrorText(error: error.toString());
                  },
                  loading: () => LottieBuilder.asset(
                        fit: BoxFit.contain,
                        AppImageAsset.loading,
                        repeat: true,
                      )),
            )
          ],
        ),
      ),
    );
  }
}
