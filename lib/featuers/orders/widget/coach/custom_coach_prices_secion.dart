import 'package:flutter/material.dart';

class CustomCoachPricesSection extends StatelessWidget {
  final String time;
  final String type;
  const CustomCoachPricesSection(
      {super.key, required this.type, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 14),
      child: Card(
          elevation: 4,
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                        Text("Type : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 58, 57, 58))),
                        Text("${type}\$",
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
                        Text("Time : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 58, 57, 58))),
                        Text("${time}\$",
                            style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 58, 57, 58)))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
