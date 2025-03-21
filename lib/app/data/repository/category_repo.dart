// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:foodyking/app/data/models/response/category_model.dart';
import 'package:foodyking/utils/api_list.dart';
import '../api/server.dart';

class CategoryRepo {
  static Server server = Server();
  static CategoryModel categoryModeldata = CategoryModel();

  static Future<CategoryModel?> getCategory() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint:
            APIList.category! + "?order_column=id&order_type=asc&status=5",
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          categoryModeldata = CategoryModel.fromJson(jsonResponse);
          return categoryModeldata;
        }
      });
      return categoryModeldata;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
