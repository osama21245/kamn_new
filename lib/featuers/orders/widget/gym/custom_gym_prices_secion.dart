import 'package:flutter/material.dart';

class CustomGymPricesSection extends StatelessWidget {
  final String startDate;
  final String expiretionDate;
  const CustomGymPricesSection(
      {super.key, required this.expiretionDate, required this.startDate});

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
                    Text("Start date : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58))),
                    Text("${startDate}",
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
                    Text("Expiration date : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58))),
                    Text("${expiretionDate}",
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
