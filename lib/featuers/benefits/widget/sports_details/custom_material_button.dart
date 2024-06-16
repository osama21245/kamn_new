import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';

import '../../../../theme/pallete.dart';

class CustomMaterialButton extends ConsumerWidget {
  final Color color;
  final Size size;
  final String serviceProviderId;
  final String title;
  final void Function() fun;
  const CustomMaterialButton(
      {super.key,
      required this.color,
      required this.serviceProviderId,
      required this.fun,
      required this.size,
      required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(usersProvider);
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(size.width * 0.02),
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(size.width * 0.02),
                bottomRight: Radius.circular(size.width * 0.02))),
        height: size.height * 0.06,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Row(
            children: [
              user!.uid == serviceProviderId
                  ? IconButton(
                      onPressed: fun,
                      icon: const Icon(
                        Icons.assignment_turned_in_outlined,
                        color: Pallete.whiteColor,
                      ))
                  : Container(
                      child: Text("      "),
                    ),
              SizedBox(
                width: size.width * 0.23,
              ),
              Text(
                title,
                style: TextStyle(
                    fontFamily: "Muller",
                    color: Pallete.whiteColor,
                    fontSize: size.width * 0.053,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
