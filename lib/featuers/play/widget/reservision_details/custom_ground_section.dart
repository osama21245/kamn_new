import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kman/models/grounds_model.dart';
import 'package:kman/theme/pallete.dart';

import '../../../../models/user_model.dart';

class CustomGroundSection extends StatelessWidget {
  final GroundModel groundModel;
  const CustomGroundSection({super.key, required this.groundModel});

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
                            backgroundImage:
                                CachedNetworkImageProvider(groundModel.image)),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          "${groundModel.name}",
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
                      "Price : ${groundModel.price}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("City : ${groundModel.city} ",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("Region  : ${groundModel.region}",
                        style: const TextStyle(fontSize: 16)),
                  ),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text("Phone : ${groundModel.groundnumber}",
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
