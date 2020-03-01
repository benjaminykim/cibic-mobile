import 'package:http/http.dart';
import 'package:http/testing.dart';

import './injection.dart';
/*
import '../models/item_model.dart';
import 'dart:convert';

class ApiProvider {
  Client client = Cient();
  fetchPosts() async {
    final response = await
    client.get("https://jsonplaceholder.typicode.com/posts/1");
    ItemModel itemModel = ItemModel.fromJson(json.decode(response.body));
    return itemModel;
  }
}
*/

MockClient testClient = MockClient((request) async {
  switch (request.url.toString()) {
    case 'https://cibic.io/api/user_id/feed_home':
      return Response(feed_home, 200);
    case 'https://cibic.io/api/user_id/feed_public':
      return Response('{}', 200);
    case 'https://cibic.io/api/profile/user_id':
      return Response('{}', 200);
    case 'https://cibic.io/api/cabildo/cablido_id':
      return Response('{}', 200);
    case 'https://cibic.io/api/activity/0':
      return Response(activity_1, 200);
    default:
      return Response('{}', 404);
  }
});