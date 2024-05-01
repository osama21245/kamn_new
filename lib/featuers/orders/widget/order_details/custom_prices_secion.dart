import 'package:flutter/material.dart';
import 'package:kman/theme/pallete.dart';

class CustomPricesSection extends StatelessWidget {
  final int price;
  final int discount;
  final int finalprice;
  const CustomPricesSection(
      {super.key,
      required this.price,
      required this.discount,
      required this.finalprice});

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
                    Text("Price = ",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58))),
                    Text("${price}\EGP",
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
                    Text("${discount}\EGP",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58)))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Final Price = ",
                        style: TextStyle(
                            fontSize: 16, color: Pallete.primaryColor)),
                    Text("${finalprice / 100}\EGP",
                        style: TextStyle(
                            fontSize: 16, color: Pallete.primaryColor))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
