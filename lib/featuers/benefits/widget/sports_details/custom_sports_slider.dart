// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kman/featuers/benefits/screens/sports/sports_details_screen.dart';

import '../../../../theme/pallete.dart';

class CustomSportsSlider extends StatefulWidget {
  Size size;
  SportsFilterStatus status;
  Alignment alignment;
  CustomSportsSlider({
    Key? key,
    required this.size,
    required this.status,
    required this.alignment,
  }) : super(key: key);

  @override
  State<CustomSportsSlider> createState() => _CustomSportsSliderState();
}

class _CustomSportsSliderState extends State<CustomSportsSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.size.width * 0.09,
          vertical: widget.size.height * 0.012),
      child: Stack(
        children: [
          Row(
            children: [
              for (SportsFilterStatus filterStatus in SportsFilterStatus.values)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (filterStatus == SportsFilterStatus.Description) {
                          widget.status = SportsFilterStatus.Description;
                          widget.alignment = Alignment.centerLeft;
                        } else if (filterStatus == SportsFilterStatus.Offers) {
                          widget.status = SportsFilterStatus.Offers;
                          widget.alignment = Alignment.centerRight;
                        }
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.size.width * 0.02),
                      child: Container(
                          width: widget.size.width * 0.26,
                          height: widget.size.height * 0.033,
                          decoration: BoxDecoration(
                            color: Pallete.greyColor,
                            borderRadius: BorderRadius.circular(
                                widget.size.width * 0.010),
                          ),
                          child: Center(
                            child: Text(
                              filterStatus.name,
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: widget.size.width * 0.03),
                            ),
                          )),
                    ),
                  ),
                ),
            ],
          ),
          AnimatedAlign(
            alignment: widget.alignment,
            duration: const Duration(milliseconds: 200),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: widget.size.width * 0.02),
              child: Container(
                width: widget.size.width * 0.34,
                height: widget.size.height * 0.033,
                decoration: BoxDecoration(
                  color: Pallete.fontColor,
                  borderRadius:
                      BorderRadius.circular(widget.size.width * 0.010),
                ),
                child: Center(
                  child: Text(
                    widget.status.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: widget.size.width * 0.03),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
