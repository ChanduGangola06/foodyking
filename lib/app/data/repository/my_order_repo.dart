import 'dart:convert';
import 'package:foodyking/app/data/models/response/order_mode.dart';
import 'package:foodyking/utils/api_list.dart';

import '../api/server.dart';

class MyOrderRepo {
  static Server server = Server();
  static OrdersModel ordersModel = OrdersModel();
  static OrdersModel activeOrdersModel = OrdersModel();

  static Future<OrdersModel?> getMyOrder() async {
    try {
      await server
          .getRequest(
        endPoint: APIList.order,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          ordersModel = OrdersModel.fromJson(jsonResponse);
          return ordersModel;
        }
      });
      return ordersModel;
    } catch (e) {
      return null;
    }
  }

  static Future<OrdersModel?> getActiveOrder() async {
    try {
      await server
          .getRequest(
        endPoint: APIList.activeOrder,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          activeOrdersModel = OrdersModel.fromJson(jsonResponse);
          return activeOrdersModel;
        }
      });
      return activeOrdersModel;
    } catch (e) {
      return null;
    }
  }
}
