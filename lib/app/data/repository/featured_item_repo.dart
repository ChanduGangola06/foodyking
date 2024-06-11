// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:foodyking/app/data/models/response/item_model.dart';
import 'package:foodyking/utils/api_list.dart';

import '../api/server.dart';

class FeaturedItemRepo {
  static Server server = Server();
  static ItemModel featuredItem = ItemModel();

  static Future<ItemModel?> getFeaturedItem() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.featuredItems!,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          featuredItem = ItemModel.fromJson(jsonResponse);
          return featuredItem;
        }
      });
      return featuredItem;
    } catch (e) {
      return null;
    }
  }
}
