// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodyking/app/data/models/response/branch_model.dart';
import 'package:foodyking/utils/api_list.dart';
import '../api/server.dart';

class BranchRepo {
  static Server server = Server();
  static BranchModel branchModelData = BranchModel();

  static Future<BranchModel> getBranch() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.branch! + "?order_column=id&order_type=asc&status=5",
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          branchModelData = BranchModel.fromJson(jsonResponse);
          return branchModelData;
        }
      });
      return branchModelData;
    } catch (e) {
      debugPrint(e.toString());
    }
    return branchModelData;
  }
}
