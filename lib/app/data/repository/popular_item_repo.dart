// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodyking/app/data/models/response/item_model.dart';
import 'package:foodyking/utils/api_list.dart';
import '../api/server.dart';

class PopularItemRepo {
  static Server server = Server();
  static ItemModel popularItem = ItemModel();

  // ignore: body_might_complete_normally_nullable
  static Future<ItemModel?> getPopularItem() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.popularItems!,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          popularItem = ItemModel.fromJson(jsonResponse);
          return popularItem;
        }
      });
      return popularItem;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
