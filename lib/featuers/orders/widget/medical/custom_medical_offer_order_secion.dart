import 'package:flutter/material.dart';
import 'package:kman/models/medical_reservision_model.dart';

class CustomMedicalOfferOrdersSection extends StatelessWidget {
  final MedicalReservisionModel medicalReservisionModel;
  const CustomMedicalOfferOrdersSection(
      {super.key, required this.medicalReservisionModel});

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
                    Text("${medicalReservisionModel.ordername}\$",
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
                    Text("${medicalReservisionModel.orderdiscount}\$",
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
