// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/featuers/auth/controller/auth_controller.dart';
import 'package:kman/featuers/benefits/controller/benefits_controller.dart';
import 'package:kman/featuers/benefits/widget/medical_details/custom_update_time.dart';
import 'package:kman/models/medical_model.dart';
import '../../../../core/class/medical_times_list.dart';
import '../../../../theme/pallete.dart';

class CustomMedicalTimesCard extends ConsumerStatefulWidget {
  List<dynamic> fromDays;
  List<dynamic> toDays;
  MedicalModel medicalModel;
  CustomMedicalTimesCard(
      {super.key,
      required this.medicalModel,
      required this.fromDays,
      required this.toDays});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomMedicalTimesCardState();
}

class _CustomMedicalTimesCardState
    extends ConsumerState<CustomMedicalTimesCard> {
  TimeOfDay _selectedTimefrom = TimeOfDay.now();
  TimeOfDay _selectedTimeto = TimeOfDay.now();
  String fromAMorPm = "PM";
  String toAMorPm = "AM";

  Future<void> _selectTime(BuildContext context, TimeOfDay selectedTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void updateTimes() {
    ref.watch(benefitsControllerProvider.notifier).updateMedicalTimes(
        widget.toDays, widget.fromDays, widget.medicalModel.id, context);
  }

  List<String> timeAMorPMList = [
    'AM',
    'PM',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = ref.watch(usersProvider);
    return Container(
      height: size.height * 0.135,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listdaysOfWeek.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: user!.state == "1" ||
                        user!.uid == widget.medicalModel.userId
                    ? () => Get.to(() => CustomUpdateTime(
                        index: i,
                        fromDays: widget.fromDays,
                        toDays: widget.toDays,
                        day: listdaysOfWeek[i],
                        medicalModel: widget.medicalModel))
                    : () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.02),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(144, 255, 255, 255),
                        borderRadius: BorderRadius.circular(size.width * 0.02)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("${listdaysOfWeek[i]}"),
                          Divider(),
                          Text("From: ${widget.fromDays[i]}"),
                          Text("To: ${widget.toDays[i]}"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
