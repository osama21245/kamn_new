// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kman/HandlingDataView.dart';
// import 'package:kman/core/class/statusrequest.dart';
// import 'package:kman/featuers/auth/controller/auth_controller.dart';
// import 'package:lottie/lottie.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:kman/core/class/reservisionParameters.dart';
// import 'package:kman/featuers/play/controller/play_controller.dart';
// import 'package:kman/models/reserved_model.dart';
// import '../../../core/common/booking_dataTime_converted.dart';
// import '../../../core/common/button.dart';
// import '../../../core/common/error_text.dart';
// import '../../../core/constants/imgaeasset.dart';

// class JoinReservisionScreen extends ConsumerStatefulWidget {
//   final String? collection;
//   final String? groundId;
//   final dynamic color;

//   JoinReservisionScreen({this.collection, this.groundId, this.color});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _JoinReservisionScreenState();
// }

// class _JoinReservisionScreenState extends ConsumerState<JoinReservisionScreen> {
//   CalendarFormat _format = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime _currentDay = DateTime.now();
//   int? _currentIndex;
//   bool _dateSelected = false;
//   bool _timeSelected = false;
//   ReserveModel? reserveModel;
//   ReservationsParams? reservationsParams;
//   bool iscomplete = true;
//   String? day;
//   List<String> timeRanges = [
//     "12:00 PM - 1:00 PM"
//         "1:00 PM - 2:00 PM",
//     "2:00 PM - 3:00 PM",
//     "3:00 PM - 4:00 PM",
//     "4:00 PM - 5:00 PM",
//     "5:00 PM - 6:00 PM",
//     "6:00 PM - 7:00 PM",
//     "7:00 PM - 8:00 PM",
//     "8:00 PM - 9:00 PM",
//     "9:00 PM - 10:00 PM",
//     "10:00 PM - 11:00 PM",
//     "11:00 PM - 12:00 AM",
//     "12:00 AM - 1:00 AM",
//     "1:00 AM - 2:00 AM",
//     "2:00 AM - 3:00 AM",
//     "3:00 AM - 4:00 AM",
//     "4:00 AM - 5:00 AM",
//     "5:00 AM - 6:00 AM",
//     "6:00 AM - 7:00 AM",
//     "7:00 AM - 8:00 AM",
//     "8:00 AM - 9:00 AM",
//     "9:00 AM - 10:00 AM",
//     "10:00 AM - 11:00 AM",
//     "11:00 AM - 12:00 PM"
//   ];

//   @override
//   void initState() {
//     day = DateConverted.getDate(_currentDay);
//     reservationsParams =
//         ReservationsParams(widget.collection!, widget.groundId!, day!);
//     super.initState();
//   }

//   void reservision(WidgetRef ref, BuildContext context,
//       ReserveModel reserveModel, int points) {
//     ref
//         .watch(playControllerProvider.notifier)
//         .reserve(context, reserveModel, points);
//   }

//   void joinGame(
//       WidgetRef ref, BuildContext context, String reserveId, int points) {
//     ref.watch(playControllerProvider.notifier).joinGame(
//         widget.collection!, widget.groundId!, reserveId, context, points);
//   }

//   void leaveGame(
//       WidgetRef ref, BuildContext context, String reserveId, int points) {
//     ref.watch(playControllerProvider.notifier).leaveGame(
//         widget.collection!, widget.groundId!, reserveId, context, points);
//   }

//   @override
//   Widget build(BuildContext context) {
//     StatusRequest statusRequest = ref.watch(playControllerProvider);
//     final userId = ref.watch(usersProvider)!.uid;
//     final user = ref.watch(usersProvider);

//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             "Reservision",
//             style: TextStyle(color: Colors.black),
//           ),
//         ),
//         body: HandlingDataView(
//             statusRequest: statusRequest,
//             widget: Padding(
//               padding: EdgeInsets.all(size.width * 0.03),
//               child: CustomScrollView(
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: Column(
//                       children: [
//                         _tableCalendar(),
//                         SizedBox(
//                           height: size.width * 0.01,
//                         ),
//                         Center(
//                           child: Text(
//                             "Select Reservation Date",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                         ),
//                         SizedBox(
//                           height: size.width * 0.04,
//                         ),
//                       ],
//                     ),
//                   ),
//                   _buildReservationsList(size),
//                   SliverToBoxAdapter(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 10, vertical: size.width * 0.07),
//                       child: Button(
//                         width: double.infinity,
//                         color: widget.color,
//                         title: iscomplete
//                             ? 'Make Appointment'
//                             : reserveModel!.collaborations.contains(userId)
//                                 ? "Leave"
//                                 : "Join",
//                         onPressed: () {
//                           // final getDate = DateConverted.getDate(_currentDay);
//                           // final getTime = DateConverted.getTime(_currentIndex!);

//                           setState(() {
//                             if (_timeSelected && _dateSelected) {
//                               if (reserveModel!.collaborations
//                                       .contains(userId) &&
//                                   !reserveModel!.iscomplete) {
//                                 leaveGame(ref, context, reserveModel!.id,
//                                     user!.points - 10);
//                                 reserveModel!.collaborations.remove(userId);
//                               } else if (!reserveModel!.collaborations
//                                       .contains(userId) &&
//                                   !reserveModel!.iscomplete) {
//                                 reserveModel!.collaborations.add(userId);
//                                 joinGame(ref, context, reserveModel!.id,
//                                     user!.points + 10);
//                               } else {
//                                 reserveModel!.userId = userId;
//                                 reserveModel!.isresrved = true;
//                                 reservision(ref, context, reserveModel!,
//                                     user!.points + 20);
//                               }
//                             }
//                           });
//                         },
//                         disable: !(_timeSelected && _dateSelected),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )));
//   }

//   //***************************************************** */

//   Widget _tableCalendar() {
//     return TableCalendar(
//       focusedDay: _focusedDay,
//       firstDay: DateTime.now(),
//       lastDay: DateTime.utc(2024, 12, 31),
//       calendarFormat: _format,
//       currentDay: _currentDay,
//       calendarStyle: CalendarStyle(
//         todayDecoration:
//             BoxDecoration(color: widget.color, shape: BoxShape.circle),
//       ),
//       availableCalendarFormats: const {CalendarFormat.month: "Month"},
//       onFormatChanged: (format) {
//         setState(() {
//           _format = format;
//         });
//       },
//       onDaySelected: (selectedDay, focusedDay) {
//         setState(() {
//           _currentDay = selectedDay;
//           _focusedDay = focusedDay;
//           _dateSelected = true;
//           day = DateConverted.getDate(_currentDay);
//           reservationsParams =
//               ReservationsParams(widget.collection!, widget.groundId!, day!);
//         });
//       },
//     );
//   }
//   //***************************************************** */

//   Widget _buildReservationsList(Size size) {
//     return ref.watch(getreservisionsProvider(reservationsParams!)).when(
//           data: (reservations) {
//             return SliverGrid(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final reservation = reservations[index];
//                   return _buildReservationItem(reservation, index);
//                 },
//                 childCount: reservations.length,
//               ),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 childAspectRatio: 1.5,
//               ),
//             );
//           },
//           error: (error, StackTrace) {
//             print(error);
//             return SliverToBoxAdapter(
//               child: ErrorText(error: error.toString()),
//             );
//           },
//           loading: () => SliverToBoxAdapter(
//             child: LottieBuilder.asset(
//               height: size.width * 0.3,
//               AppImageAsset.loading,
//               repeat: true,
//             ),
//           ),
//         );
//   }
//   //***************************************************** */

//   Widget _buildReservationItem(ReserveModel reservation, int index) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           if (reservation.iscomplete) {
//             reserveModel = reservation;
//             _currentIndex = index;
//             _timeSelected = true;
//             iscomplete = true;
//           } else {
//             reserveModel = reservation;
//             _currentIndex = index;
//             _timeSelected = true;
//             iscomplete = false;
//           }
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: _currentIndex == index ? Colors.white : Colors.black,
//           ),
//           borderRadius: BorderRadius.circular(15),
//           color: _currentIndex == index
//               ? widget.color
//               : !reservation.iscomplete
//                   ? Color.fromARGB(96, 158, 158, 158)
//                   : null,
//         ),
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '${reservation.time}',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: _currentIndex == index ? Colors.white : null,
//               ),
//             ),
//             if (!reservation.iscomplete)
//               Text(
//                 '${reservation.collaborations.length} Join',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: _currentIndex == index ? Colors.white : null,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
