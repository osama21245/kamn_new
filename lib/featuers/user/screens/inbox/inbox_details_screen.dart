import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kman/core/constants/constants.dart';
import 'package:kman/models/inbox_model.dart';

class InBoxDetailsScreen extends StatelessWidget {
  final InBoxModel inBoxModel;
  const InBoxDetailsScreen({Key? key, required this.inBoxModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(inBoxModel.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  inBoxModel.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "InBox",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage:
                    AssetImage("assets/page-1/images/kamn_new.jpg"),
                radius: 24,
              ),
              title: Text(
                "Kamn",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                Jiffy.parse(inBoxModel.sentAt.toString()).fromNow(),
                style: TextStyle(color: Colors.grey),
              ),
              trailing: Icon(Icons.mail_outline),
            ),
            SizedBox(height: 16),
            Text(
              inBoxModel.description,
              style: TextStyle(
                fontSize: size.width * 0.04,
                height: 1.5,
              ),
            ),
            if (inBoxModel.image.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.35,
                  child: InstaImageViewer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(size.width * 0.05),
                      child: CachedNetworkImage(
                        imageUrl: inBoxModel.image,
                        fit: inBoxModel.image == Constants.bannerDefault
                            ? BoxFit.cover
                            : BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
