import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:kman/HandlingDataView.dart';
import 'package:kman/core/class/statusrequest.dart';
import 'package:kman/core/common/custom_elevated_button.dart';
import 'package:kman/featuers/orders/widget/medical/custom_medical_service_orders_section.dart';
import 'package:kman/featuers/payment/screens/toggle_screen.dart';
import 'package:kman/models/passorder_model.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/common/booking_dataTime_converted.dart';
import '../../../../core/common/custom_uppersec.dart';
import '../../../../models/medical_model.dart';
import '../../../../models/medical_services_model.dart';
import '../../../../theme/pallete.dart';
import '../../../orders/controller/orders_controller.dart';
import '../../../orders/widget/medical/custom_medical_offer_order_secion.dart';
import '../../widget/medical_details/custom_medical_offer_secion.dart';
import '../../widget/medical_details/custom_medical_service_section.dart';

class FinishMedicalReservision extends ConsumerStatefulWidget {
  final MedicalModel medicalModel;
  final MedicalServicesModel medicalServicesModel;
  const FinishMedicalReservision(
      {super.key,
      required this.medicalModel,
      required this.medicalServicesModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FinishMedicalReservisionState();
}

class _FinishMedicalReservisionState
    extends ConsumerState<FinishMedicalReservision> {
  DateTime _currentDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  String qrLink = "";
  String? day;
  QRCodeShow(BuildContext context, Size size) async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(
            isShowFlashIcon: true,
          ),
        ));
    if (res is String) {
      if (res == "https://bit.ly/KAMN-كامن-AppsonGooglePlay?r=qr") {
        qrLink = res;
        setMedicalReservision(ref, context, size);
        Get.dialog(
          AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Success'),
                Text(
                  "ID:${widget.medicalServicesModel.id}",
                  style: TextStyle(fontSize: size.width * 0.016),
                )
              ],
            ),
            content: Text(
                "You've taken advantage of your ${widget.medicalServicesModel.discount}% discount at ${widget.medicalModel.name}."),
            actions: [
              TextButton(
                onPressed: () => Get.back(), // Close dialog
                child: Text('Close'),
              ),
            ],
          ),
        );
      } else {
        AwesomeDialog(
            dialogBackgroundColor: const Color.fromARGB(255, 231, 230, 230),
            barrierColor: Color.fromARGB(108, 0, 0, 0),
            context: context,
            animType: AnimType.scale,
            dialogType:
                DialogType.error, // Use NO_HEADER to remove the default header
            btnOkOnPress: () {},
            body: Column(children: [
              Text(
                'This Qr is not avaliable',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Muller",
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600),
              ),
            ]))
          ..show();
      }

      setState(() {});
    }
  }

  void setMedicalReservision(WidgetRef ref, BuildContext context, Size size) {
    ref.watch(ordersControllerProvider.notifier).setMedicalReservision(
        widget.medicalServicesModel.title,
        widget.medicalServicesModel.discount,
        widget.medicalServicesModel.description,
        day!,
        "Cash",
        widget.medicalModel.userId,
        widget.medicalModel.name,
        widget.medicalServicesModel.id,
        "${widget.medicalModel.city}, ${widget.medicalModel.region}",
        widget.medicalServicesModel.discount,
        0,
        widget.medicalModel.id,
        context);
  }

  @override
  void initState() {
    day = DateConverted.getDate(_currentDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StatusRequest statusRequest = ref.watch(ordersControllerProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: HandlingDataView(
        statusRequest: statusRequest,
        widget: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 5),
                child: CustomUpperSec(
                    size: size,
                    color: Pallete.fontColor,
                    title: "Finish reservision")),
            SizedBox(
              height: size.height * 0.027,
            ),
            Container(
              height: size.height * 0.73,
              child: ListView(
                children: [
                  CustomMedicalOfferSection(
                    medicalServicesModel: widget.medicalServicesModel,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.0),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  CustomMedicalServiceSection(
                      medicalModel: widget.medicalModel,
                      medicalServicesModel: widget.medicalServicesModel),
                  // SizedBox(
                  //   height: size.width * 0.01,
                  // ),
                  // Center(
                  //   child: Text(
                  //     "Select Reservation Date",
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  //   ),
                  // ),
                  // CustomElevatedButton(
                  //     size: size,
                  //     color: Pallete.fontColor,
                  //     title: "Online payment",
                  //     sizeofwidth: size.width * 0.5,
                  //     sizeofhight: size.width * 0.02,
                  //     onTap: () {
                  //       PassOrderModel passOrderModel = PassOrderModel(
                  //           discount:
                  //               int.parse(widget.medicalServicesModel.discount),
                  //           totalPrice: 0,
                  //           price: 0,
                  //           seviceProviderId: widget.medicalModel.userId,
                  //           serviceProviderName: "${widget.medicalModel.name}",
                  //           ordername: widget.medicalServicesModel.title,
                  //           orderDescription:
                  //               widget.medicalServicesModel.description,
                  //           mixOrSeparateOrGroupOrPrivet:
                  //               "${widget.medicalModel.city}, ${widget.medicalModel.region}",
                  //           orderplanTime: day!);
                  //       Get.to(() => ToggleScreen(
                  //           passOrderModel: passOrderModel,
                  //           collection: "medical"));
                  //     }),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.03),
                    child: Column(
                      children: [
                        _tableCalendar(),
                        SizedBox(
                          height: size.width * 0.04,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CustomElevatedButton(
                size: size,
                color: Pallete.fontColor,
                title: "Make reservision",
                sizeofwidth: size.width * 0.57,
                sizeofhight: size.width * 0.02,
                onTap: () => setMedicalReservision(ref, context, size)),
          ],
        ),
      )),
    );
  }

  Widget _tableCalendar() {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2024, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      calendarStyle: CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Pallete.fontColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {CalendarFormat.month: "Month"},
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusedDay = focusedDay;
          day = DateConverted.getDate(_currentDay);
          print("$day===========================================");
        });
      },
    );
  }
}
