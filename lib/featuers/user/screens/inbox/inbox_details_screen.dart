import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kman/models/inbox_model.dart';

class InBoxDetailsScreen extends StatelessWidget {
  final InBoxModel inBoxModel;
  const InBoxDetailsScreen({Key? key, required this.inBoxModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Text("${inBoxModel.title}"),
              Container(
                child: Text("InBox"),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 2,
                )),
              )
            ],
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/page-1/images/kamn_noBG.png"),
            ),
            title: Text("Kamn"),
            subtitle: Text(inBoxModel.sentAt.toString()),
          ),
          Text(inBoxModel.description),
          if (inBoxModel.image != "")
            Container(
                width: 200,
                child: CachedNetworkImage(
                  imageUrl: inBoxModel.image,
                  fit: BoxFit.contain,
                ))
        ],
      ),
    );
  }
}
