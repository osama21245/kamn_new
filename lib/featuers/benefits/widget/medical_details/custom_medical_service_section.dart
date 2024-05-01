import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kman/models/medical_model.dart';
import 'package:kman/theme/pallete.dart';

import '../../../../models/medical_services_model.dart';

class CustomMedicalServiceSection extends StatelessWidget {
  final MedicalModel medicalModel;
  final MedicalServicesModel medicalServicesModel;
  const CustomMedicalServiceSection(
      {super.key,
      required this.medicalModel,
      required this.medicalServicesModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.01),
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
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
                              CachedNetworkImageProvider(medicalModel.image)),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        "${medicalModel.name}",
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
                    "Specialization : ${medicalModel.specialization}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text("City : ${medicalModel.city} ",
                      style: const TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text("Region  : ${medicalModel.region}",
                      style: const TextStyle(fontSize: 16)),
                ),
                const Divider(thickness: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text("Phone : ${medicalServicesModel.title}",
                      style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
