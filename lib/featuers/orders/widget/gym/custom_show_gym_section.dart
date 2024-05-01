// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kman/featuers/coaches-gyms/screens/gym_details_screen.dart';
// import 'package:kman/theme/pallete.dart';

// import '../../../../models/gym_model.dart';
// import '../../../../models/user_model.dart';

// class CustomShowGymSection extends StatelessWidget {
//   final GymModel gymModel;
//   const CustomShowGymSection({super.key, required this.gymModel});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.all(size.width * 0.01),
//       child: Card(
//         color: Colors.white,
//         elevation: 6,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0, bottom: 17),
//                   child: Row(
//                     children: [
//                       InkWell(onTap: ()=>Get.to(()=>GymDetailsScreen( collection: collection, gymModel: ,)),
//                         child: CircleAvatar(
//                             backgroundColor: Pallete.primaryColor,
//                             radius: size.width * 0.05,
//                             backgroundImage:
//                                 CachedNetworkImageProvider(gymModel.image)),
//                       ),
//                       SizedBox(
//                         width: size.width * 0.02,
//                       ),
//                       Text(
//                         "${gymModel.name}",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Pallete.primaryColor,
//                             fontSize: size.width * 0.04),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 6.0),
//                   child: Text(
//                     "ID : ${userModel.uid}",
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 6.0),
//                   child: Text("City : ${userModel.city} ",
//                       style: const TextStyle(fontSize: 16)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 6.0),
//                   child: Text("Age  : ${userModel.age}",
//                       style: const TextStyle(fontSize: 16)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 6.0),
//                   child: Text("Gender : ${userModel.gender}",
//                       style: const TextStyle(fontSize: 16)),
//                 ),
//                 const Divider(thickness: 2),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 6.0),
//                   child: Text("Phone : ${userModel.phone}",
//                       style: const TextStyle(fontSize: 16)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
