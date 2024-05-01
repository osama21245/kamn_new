import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kman/featuers/user/widget/my%20Play/custom_get_user_joined_resevisions.dart';
import 'package:kman/featuers/user/widget/my%20Play/custom_get_resevisions.dart';
import 'package:kman/theme/pallete.dart';
import '../../../HandlingDataView.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/common/custom_play_uppersec.dart';
import '../../../core/common/custom_play_uppersec_logo.dart';
import '../../../core/providers/checkInternet.dart';
import '../../auth/controller/auth_controller.dart';
import '../widget/ground_admin/custom_get_groundowner_resevisions.dart';

class GroundOwnerReservisionsScreen extends ConsumerStatefulWidget {
  const GroundOwnerReservisionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyReservisionsScreenState();
}

class _MyReservisionsScreenState
    extends ConsumerState<GroundOwnerReservisionsScreen> {
  StatusRequest statusRequest = StatusRequest.success;

  checkinternet() async {
    setState(() {
      statusRequest = StatusRequest.loading2;
    });

    if (await checkInternet()) {
      setState(() {
        statusRequest = StatusRequest.success;
      });
    } else {
      setState(() {
        statusRequest = StatusRequest.offlinefalire2;
      });
    }
  }

  @override
  void initState() {
    checkinternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final color = Color.fromARGB(255, 10, 107, 185);
    final user = ref.read(usersProvider);
    List<Color> backGroundGridentColor = Pallete.primaryGridentColors;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomPlayUpperSecLogo(
              title: "My Reservisions",
              color: color,
              size: size,
              onLogoTap: () {},
            ),
            SizedBox(
              height: size.height * 0.013,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.13),
              child: const Divider(
                thickness: 2,
                color: Color.fromARGB(94, 146, 146, 146),
              ),
            ),
            SizedBox(
              height: size.width * 0.01,
            ),
            HandlingDataView(
                statusRequest: statusRequest,
                widget: CustomGetGroundOwnerReservisions())
          ],
        ),
      ),
    );
  }
}
