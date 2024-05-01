import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kman/models/qr_order_model.dart';

class CustomSportsPricesSection extends StatelessWidget {
  final QrOrderModel qrOrderModel;
  const CustomSportsPricesSection({super.key, required this.qrOrderModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 14),
      child: Card(
          color: Colors.white,
          elevation: 4,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.016),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size.width * 0.01),
                  child: Container(
                    width: size.width * 0.26,
                    height: size.width * 0.3,
                    child: CachedNetworkImage(
                      imageUrl: qrOrderModel.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
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
                    Text("Price : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58))),
                    Text("${qrOrderModel.offerPrice}",
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
                    Text("Discount : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58))),
                    Text("${qrOrderModel.offerDiscount}",
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
                    Text("Final Price : ",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 58, 57, 58))),
                    Text(
                        qrOrderModel.offerPrice == "Public Offer"
                            ? qrOrderModel.offerPrice
                            : "${int.parse(qrOrderModel.offerPrice) - ((int.parse(qrOrderModel.offerDiscount) / 100) * int.parse(qrOrderModel.offerPrice))}",
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
