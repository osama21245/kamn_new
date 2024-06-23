import 'dart:io';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");

    if (result[0].rawAddress.isNotEmpty && result.isNotEmpty) {
      return true;
    }
  } on SocketException catch (e) {
    return false;
  }
}

// Future<void> checkInternet() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       // No internet connection
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("No Internet"),
//           content: Text("Please check your internet connection and try again."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text("OK"),
//             ),
//           ],
//         ),
//       );
//     } else {
//       // Internet connection is available
//       // Add any additional actions if needed
//     }
//   }
