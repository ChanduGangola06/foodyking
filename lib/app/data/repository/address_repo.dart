import 'dart:convert';
import 'package:foodyking/app/data/models/response/address_list_model.dart';
import 'package:foodyking/utils/api_list.dart';

import '../api/server.dart';

class AddressRepo {
  static Server server = Server();
  static AddressListModel addressListModel = AddressListModel();

  static Future<AddressListModel?> getAddressList() async {
    try {
      await server
          .getRequest(
        endPoint: APIList.addressList,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          addressListModel = AddressListModel.fromJson(jsonResponse);
          return addressListModel;
        }
      });
      return addressListModel;
    } catch (e) {
      return null;
    }
  }
}
