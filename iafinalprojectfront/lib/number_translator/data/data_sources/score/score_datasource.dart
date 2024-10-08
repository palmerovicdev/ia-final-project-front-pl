import 'package:flutter/cupertino.dart';

import '../../../../config/config_data/configuration_data.dart';
import '../../../../config/connection/connection_helper.dart';
import '../../../../config/service_locator/service_locator.dart';
import '../../models/general_users_response.dart';
import '../../models/user_score_model.dart';

abstract class ScoreDatasource {
  Future<bool> save(UserScoreModel userModel);

  Future<List<UserScoreModel>> getAll();
}

class ScoreDatasourceImpl extends ScoreDatasource {
  final ConnectionHelper connectionHelper;

  ScoreDatasourceImpl({required this.connectionHelper});

  @override
  Future<List<UserScoreModel>> getAll() async {
    var response = <String, dynamic>{};
    try {
      if (serviceLocator.get<ConfigurationData>().debugging) {
        response = {
          "version": "0",
          "response": {
            "status": "200",
            "message": "",
            "data": [
              {"username": "pepe", "score": "123123"},
              {"username": "ramon", "score": "123123"},
              {"username": "antonio", "score": "123123"},
              {"username": "chancleta", "score": "123123"},
              {"username": "camello", "score": "123123"},
              {"username": "televisor", "score": "123123"}
            ]
          }
        };
        return GeneralUsersResponse<UserScoreResponse>.fromJson(response, true)
            .response
            .data
            .map((e) => UserScoreModel(
                  username: e.username,
                  score: e.score,
                  date: e.date,
                ))
            .toList();
      }
      debugPrint('baseUrl: ${connectionHelper.dio.options.baseUrl}');
      response = (await connectionHelper.dio.get(
        '/user/score/index',
      ))
          .data;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return [];
    }

    return GeneralUsersResponse<UserScoreResponse>.fromJson(response, true)
        .response
        .data
        .map((e) => UserScoreModel(
              username: e.username,
              score: e.score,
      date: e.date,
            ))
        .toList();
  }

  @override
  Future<bool> save(UserScoreModel userModel) async {
    var response = <String, dynamic>{};
    try {
      if (serviceLocator.get<ConfigurationData>().debugging) {
        response = {
          "version": "0",
          "response": {
            "status": "200",
            "message": "",
            "data": [
              {"username": "pepe", "score": "123123"}
            ]
          }
        };
        debugPrint('response: $response');
        return response['response']['status'] == '200';
      }
      debugPrint('baseUrl: ${connectionHelper.dio.options.baseUrl}');
      response = (await connectionHelper.dio.post(
        '/user/score/store',
        data: userModel.toJson(),
      ))
          .data;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }

    return response['response']['status'] == '200';
  }
}