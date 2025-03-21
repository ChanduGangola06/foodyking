import 'dart:convert';
import 'package:foodyking/app/data/models/response/category_wise_item_model.dart';
import 'package:foodyking/utils/api_list.dart';
import '../api/server.dart';

class CategoryWiseItemRepo {
  static Server server = Server();
  static CategoryWiseItemModel categoryWiseItemModel = CategoryWiseItemModel();

  static Future<CategoryWiseItemModel?> getCategoryWiseItem(String slug) async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.categoryWiseItem! + slug.toString(),
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          categoryWiseItemModel = CategoryWiseItemModel.fromJson(jsonResponse);

          return categoryWiseItemModel;
        }
      });
      return categoryWiseItemModel;
    } catch (e) {
      return categoryWiseItemModel;
    }
  }
}
