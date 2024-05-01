import 'package:kman/core/class/crud.dart';

import '../../linksApi.dart';

class NotficationData {
  Crud crud;

  NotficationData(this.crud);
  pushNotifications(String title, String body, String topic) async {
    var response = await crud.postData(Apilinks.pushNotifications, {
      "title": "$title",
      "body": "$body",
      "topic": "$topic",
    });
    return response.fold((l) => l, (r) => r);
  }
}
