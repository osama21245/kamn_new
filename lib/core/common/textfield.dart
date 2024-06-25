import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/pallete.dart';

class TextFiled extends ConsumerWidget {
  String name;
  Color color;
  bool? ispassword;
  bool? istakenum;
  bool? keytypeisnumber;
  String? Function(String?)? validator;
  TextEditingController controller;
  TextFiled(
      {super.key,
      required this.name,
      required this.color,
      this.ispassword,
      this.istakenum,
      this.keytypeisnumber = false,
      required this.controller,
      this.validator});
  bool showAndHidePass = false;
  void changestate() {
    showAndHidePass = !showAndHidePass;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return TextFormField(
          maxLines: null,
          keyboardType: keytypeisnumber! ? TextInputType.phone : null,
          controller: controller,
          validator: validator,
          obscureText: showAndHidePass,
          decoration: InputDecoration(
            suffixIcon: ispassword == null
                ? null
                : InkWell(
                    onTap: () {
                      changestate();
                      setState(() {});
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                    ),
                  ),
            contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            enabledBorder: OutlineInputBorder(
              borderSide: istakenum == null
                  ? BorderSide(
                      color: Pallete
                          .fontColor, // Set the color you want for the enabled border
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
            border: OutlineInputBorder(
                borderSide: istakenum != null ? BorderSide.none : BorderSide(),
                borderRadius: BorderRadius.circular(size.width * 0.02)),
            hintText: name,
            hintStyle: TextStyle(
                color: color,
                fontFamily: "Muller",
                fontSize: size.width * 0.037,
                fontWeight: FontWeight.w500),
          ),
        );
      },
    );
  }
}
