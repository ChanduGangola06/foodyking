// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:foodyking/app/data/models/response/item_model.dart';
import 'package:foodyking/utils/api_list.dart';
import '../api/server.dart';

class ItemRepo {
  static Server server = Server();
  static ItemModel itemModel = ItemModel();

  static Future<ItemModel?> getItem() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.itemList! + "?status=5",
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          itemModel = ItemModel.fromJson(jsonResponse);
          return itemModel;
        }
      });
      return itemModel;
    } catch (e) {
      return null;
    }
  }
}
