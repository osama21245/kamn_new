import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/chat_controller.dart';
import '../widget/TextField.dart';
import '../widget/call_pickup_screen.dart';
import '../widget/call_screen.dart';
import '../widget/messges.dart';

class MessagesScreen extends ConsumerStatefulWidget {
  final String uid;

  const MessagesScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen> {
  bool isloading = false;
  final message = TextEditingController();
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    message.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // void makeCall(
  //   String receiverId,
  //   String receiverName,
  //   String receiverPic,
  // ) {
  //   ref
  //       .watch(ChatControllerProider.notifier)
  //       .makeCall(receiverId, receiverName, receiverPic, context);
  // }

  @override
  Widget build(BuildContext context) {
    // final currentTheme = ref.watch(themeNotiferProvider);
    // bool isGuest = !user.isAuthanticated;
    // Size size = MediaQuery.of(context).size;
    // bool imageloading = ref.watch(ChatControllerProider);
// CallPickupScreen(
//       scaffold:     );

    return Scaffold(
      appBar: ref.watch(getUserDataProvider(widget.uid)).when(data: (user) {
        return AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name}',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Text('${user.isonline == true ? "online" : "offline"}',
                      style: TextStyle(fontSize: 10, color: Colors.grey)),
                  SizedBox(
                    width: 5,
                  ),
                  if (user.isonline)
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.green,
                    )
                ],
              )
            ],
          ),
          centerTitle: false,
          actions: [
            // IconButton(
            //     onPressed: () {
            //       makeCall(user.uid, user.name, user.profilePic);
            //     },
            //     icon: Icon(Icons.call)),
            Builder(builder: (context) {
              return IconButton(
                icon: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(user.profilePic),
                ),
                onPressed: () {},
              );
            }),
          ],
        );
      }, error: (error, StackTrace) {
        print(error);
        ;
        ErrorText(error: error.toString());
      }, loading: () {
        Loader();
      }),
      body: InkWell(
        onTap: () {
          focusNode.unfocus();
        },
        child: Column(
          children: [
            MessageBubble(
              scrollController: scrollController,
              uid: widget.uid,
            ),
            MssagesTextField(
              focusNode: focusNode,
              message: message,
              scrollController: scrollController,
              uid: widget.uid,
            )
          ],
        ),
      ),
    );
  }
}
