import 'package:flutter/material.dart';
import 'package:kman/models/medical_services_model.dart';
import 'package:kman/theme/pallete.dart';

import '../../../../models/offers_model.dart';

class CustomMedicalOfferSection extends StatelessWidget {
  final MedicalServicesModel medicalServicesModel;
  const CustomMedicalOfferSection(
      {super.key, required this.medicalServicesModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 14),
      child: Card(
          color: Colors.white,
          elevation: 4,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Service = ",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58))),
                    Text("${medicalServicesModel.title}",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58)))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discount = ",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58))),
                    Text("${medicalServicesModel.discount}\$",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58)))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
