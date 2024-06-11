import 'dart:convert';
import 'package:foodyking/app/data/models/response/profile_model.dart';
import 'package:foodyking/utils/api_list.dart';

import '../api/server.dart';

class ProfileRepo {
  static Server server = Server();
  static ProfileModel profileModelData = ProfileModel();

  static Future<ProfileModel?> getProfile() async {
    try {
      await server
          .getRequest(
        endPoint: APIList.profile,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          profileModelData = ProfileModel.fromJson(jsonResponse);
          return profileModelData;
        }
      });
      return profileModelData;
    } catch (e) {
      return null;
    }
  }
}
