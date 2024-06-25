import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kman/theme/pallete.dart';

import '../../../../models/user_model.dart';

class CustomUserSection extends StatelessWidget {
  final UserModel userModel;
  const CustomUserSection({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 17),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Pallete.primaryColor,
                            radius: size.width * 0.05,
                            backgroundImage: CachedNetworkImageProvider(
                                userModel.profilePic)),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "${userModel.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Pallete.primaryColor,
                              fontSize: size.width * 0.04),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      "ID : ${userModel.uid}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("City : ${userModel.city} ",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("Age  : ${userModel.age}",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("Gender : ${userModel.gender}",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("Phone : ${userModel.phone}",
                        style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
