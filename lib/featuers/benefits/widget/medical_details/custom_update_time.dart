// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/core/common/custom_elevated_button.dart';
import '../../../../models/medical_model.dart';
import '../../../../theme/pallete.dart';
import '../../controller/benefits_controller.dart';

class CustomUpdateTime extends ConsumerStatefulWidget {
  List<dynamic> fromDays;
  List<dynamic> toDays;
  int index;
  String day;

  MedicalModel medicalModel;
  CustomUpdateTime({
    required this.index,
    required this.fromDays,
    required this.toDays,
    required this.day,
    required this.medicalModel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomUpdateTimeState();
}

class _CustomUpdateTimeState extends ConsumerState<CustomUpdateTime> {
  TimeOfDay _selectedTimefrom = TimeOfDay.now();
  TimeOfDay _selectedTimeto = TimeOfDay.now();

  Future<void> _selectTime(
      BuildContext context, TimeOfDay selectedTime, String type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        if (type == 'from') {
          _selectedTimefrom = picked;
        } else {
          _selectedTimeto = picked;
        }
      });
    }
  }

  void updateTimes() {
    ref.watch(benefitsControllerProvider.notifier).updateMedicalTimes(
        widget.toDays, widget.fromDays, widget.medicalModel.id, context);
    setState(() {});
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.all(10),
      height: size.height,
      child: ListView(
        children: [
          Text(
            "${widget.day}",
            style: TextStyle(
                fontSize: size.width * 0.05, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "From: ${_selectedTimefrom.format(context)}",
                style: TextStyle(fontSize: size.width * 0.04),
              ),
              CustomElevatedButton(
                size: size,
                color: Pallete.whiteOpacityColor,
                title: "Change",
                sizeofwidth: size.width * 0.3,
                sizeofhight: size.height * 0.05,
                onTap: () => _selectTime(context, _selectedTimefrom, 'from'),
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => _selectTime(context, _selectedTimeto, 'to'),
                child: Text(
                  "To: ${_selectedTimeto.format(context)}",
                  style: TextStyle(fontSize: size.width * 0.04),
                ),
              ),
              CustomElevatedButton(
                size: size,
                color: Pallete.whiteOpacityColor,
                title: "Change",
                sizeofwidth: size.width * 0.3,
                sizeofhight: size.height * 0.05,
                onTap: () => _selectTime(context, _selectedTimeto, 'to'),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: ElevatedButton(
              onPressed: () {
                widget.fromDays[widget.index] =
                    "${_selectedTimefrom.format(context).toString()}";
                widget.toDays[widget.index] =
                    "${_selectedTimeto.format(context).toString()}";
                updateTimes();
              },
              child: Text(
                'Update',
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontFamily: "Muller",
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.6, size.height * 0.04),
                  backgroundColor: Color.fromARGB(255, 52, 180, 189),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.02))),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: ElevatedButton(
              onPressed: () {
                widget.fromDays[widget.index] = "Closed";
                widget.toDays[widget.index] = "Closed";
                updateTimes();
              },
              child: Text(
                'Close',
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontFamily: "Muller",
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width * 0.6, size.height * 0.04),
                  backgroundColor: Color.fromARGB(255, 52, 180, 189),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.02))),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: Pallete.listofGridientCard,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(3.14 / 4)),
      ),
    )));
  }
}
